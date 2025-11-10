module "function_services_dx" {
  source  = "pagopa-dx/azure-function-app/azurerm"
  version = "~> 2.0"

  environment = {
    prefix          = var.prefix
    env_short       = var.env_short
    location        = var.location_itn
    app_name        = "funcsvc"
    instance_number = "01"
  }

  resource_group_name = data.azurerm_resource_group.services_itn_rg.name

  virtual_network = {
    name                = var.vnet_common_name_itn
    resource_group_name = var.common_resource_group_name_itn
  }

  subnet_cidr                          = var.services_snet_cidr_old
  health_check_path                    = "/api/info"
  subnet_pep_id                        = data.azurerm_subnet.private_endpoints_subnet_itn.id
  private_dns_zone_resource_group_name = data.azurerm_resource_group.weu-common.name

  app_settings = merge(
    local.function_services.app_settings_common,
    {
      "INTERNAL_STORAGE_CONNECTION_STRING" = module.services_storage_account.primary_connection_string
      # Disabled functions on slot - trigger, queue and timer
      # mark this configurations as slot settings
      "AzureWebJobs.CreateNotification.Disabled"     = "0"
      "AzureWebJobs.EmailNotification.Disabled"      = "0"
      "AzureWebJobs.OnFailedProcessMessage.Disabled" = "0"
      "AzureWebJobs.ProcessMessage.Disabled"         = "0"
      "AzureWebJobs.WebhookNotification.Disabled"    = "0"
      "APPINSIGHTS_CLOUD_ROLE_NAME"                  = "io-p-itn-funcsvc-func-01",
    }
  )

  sticky_app_setting_names = [
    "APPINSIGHTS_CLOUD_ROLE_NAME",
    "AzureWebJobs.CreateNotification.Disabled",
    "AzureWebJobs.EmailNotification.Disabled",
    "AzureWebJobs.OnFailedProcessMessage.Disabled",
    "AzureWebJobs.ProcessMessage.Disabled",
    "AzureWebJobs.WebhookNotification.Disabled",
  ]

  slot_app_settings = merge(
    local.function_services.app_settings_common,
    {
      "INTERNAL_STORAGE_CONNECTION_STRING" = module.services_storage_account.primary_connection_string
      # Disabled functions on slot - trigger, queue and timer
      # mark this configurations as slot settings
      "AzureWebJobs.CreateNotification.Disabled"     = "1"
      "AzureWebJobs.EmailNotification.Disabled"      = "1"
      "AzureWebJobs.OnFailedProcessMessage.Disabled" = "1"
      "AzureWebJobs.ProcessMessage.Disabled"         = "1"
      "AzureWebJobs.WebhookNotification.Disabled"    = "1"
      "APPINSIGHTS_CLOUD_ROLE_NAME"                  = "io-p-itn-funcsvc-func-01-staging",
    }
  )

  action_group_id = data.azurerm_monitor_action_group.error_action_group.id

  tags = var.tags
}

resource "azurerm_resource_group" "function_services_rg" {
  name     = "${var.project_itn}-platform-services-rg-01"
  location = var.location_itn
  tags     = var.tags
}

module "function_services" {
  source  = "pagopa-dx/azure-function-app/azurerm"
  version = "~> 4.0"

  environment = {
    prefix          = var.prefix
    env_short       = var.env_short
    location        = var.location_itn
    app_name        = "services"
    instance_number = "01"
  }

  size = "P2mv3"

  resource_group_name = azurerm_resource_group.function_services_rg.name

  virtual_network = {
    name                = var.vnet_common_name_itn
    resource_group_name = var.common_resource_group_name_itn
  }

  subnet_cidr                          = var.services_snet_cidr
  health_check_path                    = "/api/info"
  subnet_pep_id                        = data.azurerm_subnet.private_endpoints_subnet_itn.id
  private_dns_zone_resource_group_name = data.azurerm_resource_group.weu-common.name

  app_settings = merge(
    local.function_services.app_settings_common,
    {
      # Disabled functions on slot - trigger, queue and timer
      # mark this configurations as slot settings
      "AzureWebJobs.CreateNotification.Disabled"     = "0"
      "AzureWebJobs.EmailNotification.Disabled"      = "0"
      "AzureWebJobs.OnFailedProcessMessage.Disabled" = "0"
      "AzureWebJobs.ProcessMessage.Disabled"         = "0"
      "AzureWebJobs.WebhookNotification.Disabled"    = "0"
      "APPINSIGHTS_CLOUD_ROLE_NAME"                  = "io-p-itn-services-func-01",
    }
  )

  sticky_app_setting_names = [
    "APPINSIGHTS_CLOUD_ROLE_NAME",
    "AzureWebJobs.CreateNotification.Disabled",
    "AzureWebJobs.EmailNotification.Disabled",
    "AzureWebJobs.OnFailedProcessMessage.Disabled",
    "AzureWebJobs.ProcessMessage.Disabled",
    "AzureWebJobs.WebhookNotification.Disabled",
  ]

  slot_app_settings = merge(
    local.function_services.app_settings_common,
    {
      # Disabled functions on slot - trigger, queue and timer
      # mark this configurations as slot settings
      "AzureWebJobs.CreateNotification.Disabled"     = "1"
      "AzureWebJobs.EmailNotification.Disabled"      = "1"
      "AzureWebJobs.OnFailedProcessMessage.Disabled" = "1"
      "AzureWebJobs.ProcessMessage.Disabled"         = "1"
      "AzureWebJobs.WebhookNotification.Disabled"    = "1"
      "APPINSIGHTS_CLOUD_ROLE_NAME"                  = "io-p-itn-services-func-01-staging",
    }
  )

  action_group_ids = [data.azurerm_monitor_action_group.error_action_group.id]

  tags = var.tags
}
