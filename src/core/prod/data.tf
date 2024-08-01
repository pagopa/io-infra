data "azurerm_client_config" "current" {}

data "azurerm_virtual_network" "weu_beta" {
  name                = "${local.project_weu}-beta-vnet"
  resource_group_name = "${local.project_weu}-beta-vnet-rg"
}

data "azurerm_virtual_network" "weu_prod01" {
  name                = "${local.project_weu}-prod01-vnet"
  resource_group_name = "${local.project_weu}-prod01-vnet-rg"
}

# TODO: remove when app gateway module is implemented
data "azurerm_public_ip" "appgateway_public_ip" {
  name                = format("${local.project_weu_legacy}-appgateway-pip")
  resource_group_name = "${local.project_weu_legacy}-rg-external"
}

# TODO: remove when apim v2 module is implemented
data "azurerm_api_management" "apim_v2" {
  name                = "${local.project_weu_legacy}-apim-v2-api"
  resource_group_name = "${local.project_weu_legacy}-rg-internal"
}
