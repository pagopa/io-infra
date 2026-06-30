module "ioapp" {
  source              = "pagopa-dx/azure-cdn/azurerm"
  version             = "~> 0.0"
  resource_group_name = var.resource_group_cdn

  origins = {
    custom-origin = {

      host_name = "d2m1nc4792c1zk.cloudfront.net"
      priority  = 1

    }
  }

  custom_domains = [
    {
      host_name = "ioapp.it"
      dns = {
        zone_name                = var.public_dns_zones.ioapp_it.name
        zone_resource_group_name = var.resource_group_external
      }
      custom_certificate = {
        key_vault_certificate_versionless_id = data.azurerm_key_vault_certificate.ioapp_it_certificate.versionless_id
        key_vault_name                       = data.azurerm_key_vault.ioapp_it_kv.name
        key_vault_resource_group_name        = data.azurerm_key_vault.ioapp_it_kv.resource_group_name
        key_vault_has_rbac_support           = data.azurerm_key_vault.ioapp_it_kv.enable_rbac_authorization
      }
    },
    {
      host_name = "www.ioapp.it"
      dns = {
        zone_name                = var.public_dns_zones.ioapp_it.name
        zone_resource_group_name = var.resource_group_external
      }
    }
  ]

  diagnostic_settings = {
    enabled                    = true
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }

  environment = {
    prefix          = var.prefix
    env_short       = var.env_short
    location        = var.location
    app_name        = "ioapp"
    instance_number = "01"
  }
  tags = var.tags
}
