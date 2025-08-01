resource "azurerm_resource_group" "services_rg" {
  count    = var.function_services_count
  name     = format("%s-services-rg-%d", var.project_itn, count.index + 1) #TODO is itn convention correct ?
  location = var.location_itn

  tags = var.tags
}

module "function_services_dx" {
  count   = var.function_services_count
  source  = "pagopa-dx/azure-function-app/azurerm"
  version = "~> 2.0"

  environment = {
    prefix          = var.prefix
    env_short       = var.env_short
    location        = var.location_itn
    app_name        = "services"
    domain          = "IO-COMMONS"
    instance_number = count.index + 1
  }

  resource_group_name = azurerm_resource_group.services_rg[count.index].name

  virtual_network = {
    name                = var.vnet_common_name_itn
    resource_group_name = var.common_resource_group_name_itn
  }

  health_check_path = "/api/info"
  subnet_pep_id     = data.azurerm_subnet.private_endpoints_subnet_itn.id

  app_settings = merge(
    local.function_services.app_settings_common,
    count.index == 0 ? local.function_services.app_settings_1 : {},
    count.index == 1 ? local.function_services.app_settings_2 : {},
    {
      # Disabled functions on slot - trigger, queue and timer
      # mark this configurations as slot settings
      "AzureWebJobs.CreateNotification.Disabled"     = "0"
      "AzureWebJobs.EmailNotification.Disabled"      = "0"
      "AzureWebJobs.OnFailedProcessMessage.Disabled" = "0"
      "AzureWebJobs.ProcessMessage.Disabled"         = "0"
      "AzureWebJobs.WebhookNotification.Disabled"    = "0"
    }
  )

  sticky_app_setting_names = [
    "AzureWebJobs.CreateNotification.Disabled",
    "AzureWebJobs.EmailNotification.Disabled",
    "AzureWebJobs.OnFailedProcessMessage.Disabled",
    "AzureWebJobs.ProcessMessage.Disabled",
    "AzureWebJobs.WebhookNotification.Disabled",
  ]

  slot_app_settings = merge(
    local.function_services.app_settings_common, {
      # Disabled functions on slot - trigger, queue and timer
      # mark this configurations as slot settings
      "AzureWebJobs.CreateNotification.Disabled"     = "1"
      "AzureWebJobs.EmailNotification.Disabled"      = "1"
      "AzureWebJobs.OnFailedProcessMessage.Disabled" = "1"
      "AzureWebJobs.ProcessMessage.Disabled"         = "1"
      "AzureWebJobs.WebhookNotification.Disabled"    = "1"
    }
  )

  action_group_id = data.azurerm_monitor_action_group.error_action_group.id

  tags = var.tags
}

resource "azurerm_private_endpoint" "function_services" {
  count               = var.function_services_count
  name                = format("%s-services-pep-%d", var.project_itn, count.index + 1)
  location            = var.location_itn
  resource_group_name = azurerm_resource_group.services_rg[count.index].name
  subnet_id           = data.private_endpoints_subnet_itn.id

  private_service_connection {
    name                           = format("%s-services-pep-%d", var.project_itn, count.index + 1)
    private_connection_resource_id = module.function_services_dx.id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [] #TODO ?
  }

  tags = var.tags
}
