module "ioapp_cdn" {
  source              = "pagopa-dx/azure-cdn/azurerm"
  version             = "~> 0.0"
  resource_group_name = azurerm_resource_group.io_web_profile_itn_fe_rg.name

  origins = {
    custom-origin = {

      host_name = "d2m1nc4792c1zk.cloudfront.net"
      priority  = 1

    }
  }

  custom_domains = [
    {
      host_name = "ioapp.it"
      # TODO: enable dns block / import txt validation records 
      /*
      dns = {
        zone_name                = data.azurerm_dns_zone.ioapp_it.name
        zone_resource_group_name = data.azurerm_resource_group.core_ext.name
      }
      */
    }
  ]

  diagnostic_settings = {
    enabled                    = true
    log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics.id
  }

  environment = {
    prefix          = "io"
    env_short       = "p"
    location        = local.itn_location
    app_name        = "ioweb"
    instance_number = "01"
  }
  tags = var.tags
}
