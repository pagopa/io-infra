resource "azurerm_resource_group" "function_assets_cdn_itn_rg" {
  name     = "${var.project_itn}-assetscdn-rg-01"
  location = var.location_itn

  tags = var.tags
}

module "function_assets_cdn_itn" {
  source  = "pagopa-dx/azure-function-app/azurerm"
  version = "~> 3.0"

  environment = {
    prefix          = var.prefix
    env_short       = var.env_short
    location        = var.location_itn
    app_name        = "assetscdn"
    instance_number = "01"
  }

  resource_group_name = azurerm_resource_group.function_assets_cdn_itn_rg.name

  virtual_network = {
    name                = var.vnet_common_name_itn
    resource_group_name = var.common_resource_group_name_itn
  }

  subnet_cidr                          = var.assets_cdn_snet_cidr
  health_check_path                    = "/info"
  subnet_pep_id                        = data.azurerm_subnet.private_endpoints_subnet_itn.id
  private_dns_zone_resource_group_name = data.azurerm_resource_group.weu-common.name

  app_settings = local.function_assets_cdn.app_settings

  application_insights_key = data.azurerm_application_insights.application_insights.instrumentation_key

  action_group_ids = [data.azurerm_monitor_action_group.error_action_group.id]

  tags = var.tags
}
