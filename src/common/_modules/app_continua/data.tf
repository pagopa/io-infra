data "azurerm_application_insights" "application_insights" {
  name                = format("%s-ai-common", var.project)
  resource_group_name = local.resource_group_name_common
}

data "azurerm_subnet" "agw_itn_snet" {
  name                 = "${var.project}-itn-agw-snet-01"
  virtual_network_name = local.vnet_common_itn
  resource_group_name  = local.resource_group_common_itn
}

data "azurerm_subnet" "private_endpoints_subnet_itn" {
  name                 = "io-p-itn-pep-snet-01"
  virtual_network_name = var.vnet_common_name_itn
  resource_group_name  = var.common_resource_group_name_itn
}

data "azurerm_resource_group" "weu-common" {
  name = "${var.prefix}-${var.env_short}-rg-common"
}