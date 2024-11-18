module "apim" {
  source = "../_modules/apim"

  project   = local.project
  env_short = local.env_short

  tags = local.tags
}
