data "azurerm_virtual_network" "vnet_common" {
  name                = "${local.project}-vnet-common"
  resource_group_name = "${local.project}-rg-common"
}

data "azurerm_private_dns_zone" "privatelink_documents" {
  name                = "privatelink.documents.azure.com"
  resource_group_name = "${local.project}-rg-common"
}
