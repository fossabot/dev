module "jianghu-klamath" {
    source = "../../terraform-aws-defn-account"
    context = module.this.context

    providers = {
        aws = aws.jianghu-klamath
    }
}