data "azurerm_application_insights" "application_insights" {
  name                = format("%s-ai-common", var.project)
  resource_group_name = local.resource_group_name_common
}

data "azurerm_subnet" "snet_appgw" {
  name                 = "${var.project}-appgateway-snet"
  virtual_network_name = local.vnet_name_common
  resource_group_name  = local.resource_group_name_common
}
