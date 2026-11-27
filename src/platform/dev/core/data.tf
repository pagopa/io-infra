# RG

data "azurerm_resource_group" "itn_common" {
  name = "io-d-itn-common-rg-01"
}

# VNET

data "azurerm_virtual_network" "itn_common" {
  name                = "io-d-itn-common-vnet-01"
  resource_group_name = data.azurerm_resource_group.itn_common.name
}

# Log Analytics

data "azurerm_log_analytics_workspace" "itn_common" {
  name                = "${local.project}-common-log-01"
  resource_group_name = "${local.prefix}-${local.env_short}-rg-common"
}