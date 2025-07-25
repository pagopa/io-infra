data "azurerm_application_insights" "application_insights" {
  name                = format("%s-ai-common", var.project)
  resource_group_name = local.resource_group_name_common
}

data "azurerm_subnet" "snet_appgw" {
  name                 = "${var.project}-appgateway-snet"
  virtual_network_name = local.vnet_name_common
  resource_group_name  = local.resource_group_name_common
}

data "azurerm_subnet" "agw_itn_snet" {
  name                 = "${var.project}-itn-agw-snet-01"
  virtual_network_name = local.vnet_common_itn
  resource_group_name  = local.resource_group_common_itn
}