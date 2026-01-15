resource "azurerm_resource_group" "function_admin_itn_rg" {
  name     = "${var.project_itn}-platform-admin-rg-01"
  location = var.location_itn

  tags = var.tags
}

module "function_admin_itn" {
  source  = "pagopa-dx/azure-function-app/azurerm"
  version = "~> 3.0"

  environment = {
    prefix          = var.prefix
    env_short       = var.env_short
    location        = var.location_itn
    app_name        = "admin"
    instance_number = "01"
  }

  resource_group_name = azurerm_resource_group.function_admin_itn_rg.name

  virtual_network = {
    name                = var.vnet_common_name_itn
    resource_group_name = var.common_resource_group_name_itn
  }

  subnet_cidr                          = var.admin_snet_cidr
  health_check_path                    = "/info"
  subnet_pep_id                        = data.azurerm_subnet.private_endpoints_subnet_itn.id
  private_dns_zone_resource_group_name = data.azurerm_resource_group.weu-common.name
  has_durable_functions                = true

  app_settings = merge(
    local.function_admin.app_settings_common,
    {
      "AzureWebJobs.CheckXmlCryptoCVESamlResponse.Disabled"      = "1",
      "AzureWebJobs.CheckIoWebXmlCryptoCVESamlResponse.Disabled" = "1",
      "APPINSIGHTS_CLOUD_ROLE_NAME"                              = "io-p-itn-admin-func-01",
      "AzureWebJobs.UserDataDeleteOrchestratorV2.Disabled"       = "0",
      "AzureWebJobs.UserDataProcessingTrigger.Disabled"          = "0",
    }
  )

  sticky_app_setting_names = [
    "APPINSIGHTS_CLOUD_ROLE_NAME",
    "AzureWebJobs.UserDataProcessingTrigger.Disabled",
    "AzureWebJobs.SanitizeProfileEmail.Disabled",
    "AzureWebJobs.CheckXmlCryptoCVESamlResponse.Disabled",
    "AzureWebJobs.CheckIoWebXmlCryptoCVESamlResponse.Disabled",
    "AzureWebJobs.UserDataDeleteOrchestratorV2.Disabled",
    "AzureWebJobs.UserDataProcessingTrigger.Disabled",
  ]

  slot_app_settings = merge(
    local.function_admin.app_settings_common,
    {
      # Disabled functions on slot - trigger, queue and timer
      # mark this configurations as slot settings
      "AzureWebJobs.UserDataProcessingTrigger.Disabled"          = "1",
      "AzureWebJobs.SanitizeProfileEmail.Disabled"               = "1",
      "AzureWebJobs.CheckXmlCryptoCVESamlResponse.Disabled"      = "1",
      "AzureWebJobs.CheckIoWebXmlCryptoCVESamlResponse.Disabled" = "1",
      "APPINSIGHTS_CLOUD_ROLE_NAME"                              = "io-p-itn-admin-func-01-staging",
    }
  )

  application_insights_key = data.azurerm_application_insights.application_insights.instrumentation_key

  action_group_ids = [data.azurerm_monitor_action_group.error_action_group.id]

  tags = var.tags
}
