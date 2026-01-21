module "azure_cdn" {
  source              = "pagopa-dx/azure-cdn/azurerm"
  version             = "~> 0.0"
  resource_group_name = var.resource_group_cdn

  origins = {
    storage_account_origin = {

      host_name = module.cdn_storage.primary_web_host
      priority  = 1

    }
  }
  custom_domains = [
    {
      host_name = "assets.io.pagopa.it"
      dns = {
        zone_name                = var.public_dns_zones.io.name
        zone_resource_group_name = var.resource_group_external
      }
    }
  ]

  diagnostic_settings = {
    enabled                                   = true
    log_analytics_workspace_id                = var.log_analytics_workspace_id
    diagnostic_setting_destination_storage_id = var.diagnostic_settings_storage_account_id
  }

  environment = {
    prefix          = var.prefix
    env_short       = var.env_short
    location        = var.location
    app_name        = "assets"
    instance_number = "01"
  }
  tags = var.tags
}
