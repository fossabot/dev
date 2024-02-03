terraform {
  required_providers {
    aws = {
      version = "5.35.0"
      source  = "aws"
    }
  }
  backend "s3" {
    bucket         = "dfn-defn-terraform-state"
    dynamodb_table = "dfn-defn-terraform-state-lock"
    encrypt        = true
    key            = "stacks/org-defn/terraform.tfstate"
    profile        = "defn-org-sso"
    region         = "us-east-1"
  }


}

locals {
  sso_instance_arn  = "${data.aws_ssoadmin_instances.sso_instance.arns}"
  sso_instance_isid = "${data.aws_ssoadmin_instances.sso_instance.identity_store_ids}"
}

provider "aws" {
  profile = "defn-org-sso"
  region  = "us-east-2"
}
resource "aws_organizations_organization" "organization" {
  aws_service_access_principals = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
    "ram.amazonaws.com",
    "ssm.amazonaws.com",
    "sso.amazonaws.com",
    "tagpolicies.tag.amazonaws.com"
  ]
  enabled_policy_types = [
    "SERVICE_CONTROL_POLICY",
    "TAG_POLICY"
  ]
  feature_set = "ALL"
}
data "aws_ssoadmin_instances" "sso_instance" {
}
resource "aws_ssoadmin_permission_set" "admin_sso_permission_set" {
  instance_arn     = "${element(local.sso_instance_arn, 0)}"
  name             = "Administrator"
  session_duration = "PT2H"
  tags = {
    ManagedBy = "Terraform"
  }
}
resource "aws_ssoadmin_managed_policy_attachment" "admin_sso_managed_policy_attachment" {
  instance_arn       = "${aws_ssoadmin_permission_set.admin_sso_permission_set.instance_arn}"
  managed_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  permission_set_arn = "${aws_ssoadmin_permission_set.admin_sso_permission_set.arn}"
}
resource "aws_identitystore_group" "administrators_sso_group" {
  display_name      = "Administrators"
  identity_store_id = "${element(local.sso_instance_isid, 0)}"
}
resource "aws_organizations_account" "defn" {
  email = "iam+bootstrap@defn.sh"
  name  = "defn"
  tags = {
    ManagedBy = "Terraform"
  }
}
resource "aws_ssoadmin_account_assignment" "defn_admin_sso_account_assignment" {
  instance_arn       = "${aws_ssoadmin_managed_policy_attachment.admin_sso_managed_policy_attachment.instance_arn}"
  permission_set_arn = "${aws_ssoadmin_managed_policy_attachment.admin_sso_managed_policy_attachment.permission_set_arn}"
  principal_id       = "${aws_identitystore_group.administrators_sso_group.group_id}"
  principal_type     = "GROUP"
  target_id          = "${aws_organizations_account.defn.id}"
  target_type        = "AWS_ACCOUNT"
}