locals {
  aws = {
    region            = "us-west-2"
    availability_zone = "us-west-2a"
    instance_type     = data.coder_parameter.instance_type.value
    root_volume_size  = data.coder_parameter.nix_volume_size.value
  }

  owners     = ["self"]
  ami_filter = ["coder-*"]

  user_data = <<EOT
Content-Type: multipart/mixed; boundary="//"
MIME-Version: 1.0

--//
Content-Type: text/cloud-config; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cloud-config.txt"

#cloud-config
hostname: ${local.coder_name}
cloud_final_modules:
- [scripts-user, always]

--//
Content-Type: text/x-shellscript; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="userdata.txt"

#!/bin/bash

set -x

echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.d/99-dfd.conf
echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.d/99-dfd.conf
echo 'fs.inotify.max_user_instances = 10000' | sudo tee -a /etc/sysctl.d/99-dfd.conf
echo 'fs.inotify.max_user_watches = 524288' | sudo tee -a /etc/sysctl.d/99-dfd.conf
sudo sysctl -p /etc/sysctl.d/99-dfd.conf

while true; do
  if test -n "$(dig +short "cache.nixos.org" || true)"; then
    break
  fi
  sleep 5
done

sudo tailscale up --accept-dns=true --accept-routes=true --operator ubuntu --ssh --authkey "${var.tsauthkey}"

nohup sudo -H -E -u ${local.username} bash -c 'cd && (git pull || true) && cd m && exec bin/user-data.sh ${data.coder_workspace.me.access_url} ${local.coder_name}' >/tmp/cloud-init.log 2>&1 &
disown
--//--
EOT
}

provider "aws" {
  region = local.aws.region
}

data "aws_ami" "ubuntu" {
  most_recent = true

  owners = local.owners

  filter {
    name   = "name"
    values = local.ami_filter
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_iam_role" "dev" {
  name = local.coder_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = ""
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.dev.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "secretsmanager" {
  role       = aws_iam_role.dev.name
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
}

resource "aws_iam_role_policy_attachment" "admin" {
  role       = aws_iam_role.dev.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_instance_profile" "dev" {
  name = local.coder_name
  role = aws_iam_role.dev.name
}

resource "aws_secretsmanager_secret" "dev" {
  name = "${local.coder_name}-${aws_instance.dev.id}"
}

resource "aws_secretsmanager_secret_version" "dev" {
  secret_id     = aws_secretsmanager_secret.dev.id
  secret_string = "{\"coder_agent_token\":\"${coder_agent.main.token}\"}"
}

# trunk-ignore(checkov/CKV_AWS_148)
resource "aws_default_vpc" "default" {
}

resource "aws_security_group" "dev" {
  name        = local.coder_name
  description = local.coder_name

  vpc_id = aws_default_vpc.default.id

  ingress {
    description = "allow vpc ingress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["172.31.32.0/20"]
  }

  ingress {
    description      = "allow wireguard udp"
    from_port        = 41641
    to_port          = 41641
    protocol         = "udp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "allow all egress"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    "karpenter.sh/discovery" = "k3d-dfd"
  }
}

resource "aws_instance" "dev" {
  ami               = data.aws_ami.ubuntu.id
  availability_zone = local.aws.availability_zone
  instance_type     = local.aws.instance_type

  ebs_optimized = true
  monitoring    = false

  iam_instance_profile   = aws_iam_instance_profile.dev.name
  vpc_security_group_ids = [aws_security_group.dev.id]

  user_data = local.user_data

  root_block_device {
    volume_size           = local.aws.root_volume_size
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    instance_metadata_tags      = "enabled"
    http_put_response_hop_limit = 1
  }

  tags = {
    Name              = local.coder_name
    Coder_Provisioned = "true"
  }
}

resource "aws_ec2_instance_state" "dev" {
  instance_id = aws_instance.dev.id
  state       = data.coder_workspace.me.transition == "start" ? "running" : "stopped"
}
