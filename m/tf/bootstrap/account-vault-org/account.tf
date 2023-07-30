module "vault-org" {
    source = "../../mod/terraform-aws-defn-account"
    context = module.this.context

    providers = {
        aws = aws.vault-org
    }
}