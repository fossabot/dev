data "coder_workspace" "me" {}

locals {
  owner  = lower(data.coder_workspace.me.owner)
  name   = lower(data.coder_workspace.me.name)
  domain = "defn.run"

  username = "ubuntu"

  prefix     = data.coder_parameter.prefix.value
  coder_name = "${local.prefix}-${data.coder_workspace.me.owner}-${data.coder_workspace.me.name}"
  app        = "cs"
}

resource "coder_agent" "main" {
  auth = "token"

  arch                   = "amd64"
  os                     = "linux"
  startup_script_timeout = 180
  startup_script         = "workdir=${data.coder_parameter.workdir.value}; source_rev=${data.coder_parameter.source_rev.value}; ${file("${path.module}/startup.sh")}"

  display_apps {
    vscode          = false
    vscode_insiders = false
    ssh_helper      = false
  }

  env = {
    GIT_AUTHOR_NAME     = local.owner
    GIT_COMMITTER_NAME  = local.owner
    GIT_AUTHOR_EMAIL    = data.coder_workspace.me.owner_email
    GIT_COMMITTER_EMAIL = data.coder_workspace.me.owner_email

    LOCAL_ARCHIVE = "/usr/lib/locale/locale-archive"
    LC_ALL        = "C.UTF-8"

    DFD_OWNER  = local.owner
    DFD_NAME   = local.name
    DFD_PREFIX = local.prefix
    DFD_APP    = local.app

    DFD_REGISTRY = "cache.${local.domain}:5000"
    DFD_CONTEXT  = "${local.prefix}-${local.owner}-${local.name}-cluster"
  }
}

resource "coder_app" "code-server" {
  agent_id     = coder_agent.main.id
  slug         = local.app
  display_name = "code-server"
  url          = "http://localhost:13337/?folder=${data.coder_parameter.workdir.value}"
  icon         = "/icon/code.svg"
  share        = "owner"
  subdomain    = false

  healthcheck {
    url       = "http://localhost:13337/healthz"
    interval  = 5
    threshold = 6
  }
}

module "coder-login" {
  source   = "https://registry.coder.com/modules/coder-login"
  agent_id = coder_agent.main.id
}

resource "coder_metadata" "main" {
  count       = local.aws_ec2_count
  resource_id = aws_instance.dev.id

  item {
    key   = "instance type"
    value = aws_instance.dev.instance_type
  }

  item {
    key   = "disk"
    value = "${aws_instance.dev.root_block_device[0].volume_size} GiB"
  }
}
