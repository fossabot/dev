module "fogg-data" {
  source  = "../../mod/terraform-aws-defn-account"
  context = module.this.context

  providers = {
    aws = aws.fogg-data
  }
}