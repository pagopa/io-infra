module "app_services" {
  source = "../../_modules/app_services"

  location = local.location
  project  = local.project

  resource_group_name = module.resource_groups.resource_group_selfcare_be.name
  subnet_id           = module.networking.subnet_be_common.id

  frontend_hostname              = local.frontend_hostname
  backend_hostname               = local.backend_hostname
  selfcare_external_hostname     = local.selfcare_external_hostname
  apim_hostname_api_app_internal = local.apim_hostname_api_app_internal

  tags = local.tags
}
