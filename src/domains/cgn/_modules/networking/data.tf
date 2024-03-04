data "azurerm_virtual_network" "vnet_common" {
  name                = "${var.project}-vnet-common"
  resource_group_name = "${var.project}-rg-common"
}

data "azurerm_private_dns_zone" "privatelink_documents" {
  name                = "privatelink.documents.azure.com"
  resource_group_name = "${var.project}-rg-common"
}

data "azurerm_nat_gateway" "nat_gateway" {
  name                = "${var.project}-natgw"
  resource_group_name = "${var.project}-rg-common"
}
