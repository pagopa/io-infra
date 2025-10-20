resource "azurerm_resource_group" "continua_itn_rg" {
  name     = "${var.project_itn}-continua-rg-01"
  location = var.location_itn

  tags = var.tags
}

module "appservice_continua_itn" {
  source  = "pagopa-dx/azure-app-service/azurerm"
  version = "~> 2.0.0"

  environment = {
    prefix          = var.prefix
    env_short       = var.env_short
    location        = var.location_itn
    app_name        = "continua"
    instance_number = "01"
  }

  resource_group_name = azurerm_resource_group.continua_itn_rg.name
  health_check_path   = "/health"
  node_version        = 20

  subnet_cidr                          = var.continua_snet_cidr
  subnet_pep_id                        = data.azurerm_subnet.private_endpoints_subnet_itn.id
  private_dns_zone_resource_group_name = data.azurerm_resource_group.weu-common.name
  virtual_network = {
    name                = var.vnet_common_name_itn
    resource_group_name = var.common_resource_group_name_itn
  }

  app_settings = merge(local.continua_appsvc_settings)

  slot_app_settings = merge(local.continua_appsvc_settings)

  use_case = "default"

  tags = var.tags
}