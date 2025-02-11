module "apim" {
  source = "../_modules/apim"

  project   = local.project
  env_short = local.env_short
  apim = {
    name                = local.apim_v2_name
    resource_group_name = local.apim_resource_group_name
  }

  tags = local.tags
}

module "apim_itn" {
  source = "../_modules/apim"

  project   = local.project
  env_short = local.env_short
  apim = {
    name                = local.apim_itn_name
    resource_group_name = local.apim_itn_resource_group_name
  }

  tags = local.tags
}
