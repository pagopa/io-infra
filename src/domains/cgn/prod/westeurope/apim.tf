module "apim" {
  source = "../../_modules/apim"

  project                        = local.project
  env_short                      = local.env_short
  function_cgn_merchant_hostname = module.functions.function_app_cgn_merchant.hostname

  tags = local.tags
}
