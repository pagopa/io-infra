data "azurerm_virtual_network" "vnet_common" {
  name                = local.vnet_common_name
  resource_group_name = local.vnet_common_resource_group_name
}

data "azurerm_private_dns_zone" "privatelink_mongo_cosmos_azure_com" {
  name                = "privatelink.mongo.cosmos.azure.com"
  resource_group_name = format("%s-rg-common", local.product)
}

data "azurerm_subnet" "private_endpoints_subnet" {
  name                 = "pendpoints"
  virtual_network_name = local.vnet_common_name
  resource_group_name  = local.vnet_common_resource_group_name
}

data "azurerm_subnet" "pep_subnet_itn" {
  name                 = "${local.project_itn}-pep-snet-01"
  virtual_network_name = local.vnet_common_name_itn
  resource_group_name  = local.vnet_common_resource_group_name_itn
}

resource "azurerm_private_endpoint" "cosno_payments_itn" {
  name                = "${local.project_itn}-msgs-payments-cosno-pep-01"
  location            = "italynorth"
  resource_group_name = azurerm_resource_group.data_rg.name
  subnet_id           = data.azurerm_subnet.pep_subnet_itn.id

  private_service_connection {
    name                           = "${local.project_itn}-msgs-payments-cosno-pep-01"
    private_connection_resource_id = module.cosmosdb_account_mongodb.id
    is_manual_connection           = false
    subresource_names              = ["MongoDB"]
  }
}
