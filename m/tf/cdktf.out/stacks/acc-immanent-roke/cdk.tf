terraform {
  required_providers {
    aws = {
      version = "5.33.0"
      source  = "aws"
    }
  }
  backend "s3" {
    bucket         = "dfn-defn-terraform-state"
    dynamodb_table = "dfn-defn-terraform-state-lock"
    encrypt        = true
    key            = "immanent-roke/bootstrap/account-immanent-roke/terraform.tfstate"
    profile        = "defn-org-sso"
    region         = "us-east-1"
  }


}

provider "aws" {
  profile = "immanent-roke-sso"
  alias   = "immanent-roke"
}
module "immanent-roke" {
  name      = "terraform"
  namespace = "dfn"
  stage     = "defn"
  source    = "./assets/__cdktf_module_asset_26CE565C/3B662577168AEE3844EE70D2853CDA26/terraform-aws-defn-account"
  providers = {
    aws = aws.immanent-roke
  }
}