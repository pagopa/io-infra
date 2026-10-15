module "apim_itn" {
  source = "../_modules/apim"

  project = local.project
  apim = {
    name                = local.apim_itn_name
    resource_group_name = local.apim_itn_resource_group_name
  }

}
