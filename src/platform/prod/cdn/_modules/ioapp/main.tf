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

  # TODO: enable custom domain once the traffic is switched to a temporary AGW

  #custom_domains = [
  #  {
  #    host_name = "ioapp.it"
  # TODO: enable dns block / import txt validation records 
  /*
      dns = {
        zone_name                = data.azurerm_dns_zone.ioapp_it.name
        zone_resource_group_name = data.azurerm_resource_group.core_ext.name
      }
      */
  #  }
  # ]

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
