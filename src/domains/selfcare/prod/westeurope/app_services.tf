module "app_services" {
  source = "../../_modules/app_services"

  location = local.location
  project  = local.project

  resource_group_name        = module.resource_groups.resource_group_selfcare_be.name
  subnet_id                  = module.networking.subnet_be_common.id
  private_endpoint_subnet_id = module.networking.subnet_pendpoints.id

  frontend_hostname              = local.frontend_hostname
  backend_hostname               = local.backend_hostname
  selfcare_external_hostname     = local.selfcare_external_hostname
  devportal_frontend_hostname    = local.devportal_frontend_hostname
  apim_hostname_api_app_internal = local.apim_hostname_api_app_internal

  dev_portal_db_data = {
    host     = module.postgresql.dev_portal_credentials.host
    username = module.postgresql.dev_portal_credentials.username
    password = module.postgresql.dev_portal_credentials.password
  }

  subsmigrations_db_data = {
    host     = module.postgresql.subsmigrations_credentials.host
    username = module.postgresql.subsmigrations_credentials.username
    password = module.postgresql.subsmigrations_credentials.password
  }

  app_insights_ips = [
    "51.144.56.96/28",
    "51.144.56.112/28",
    "51.144.56.128/28",
    "51.144.56.144/28",
    "51.144.56.160/28",
    "51.144.56.176/28",
  ]

  tags = local.tags
}
