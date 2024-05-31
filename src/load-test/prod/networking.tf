resource "azurerm_virtual_network" "weu_load_test" {
  name                = "${local.project}-load-test-vnet-01"
  resource_group_name = azurerm_resource_group.load_test.name
  location            = azurerm_resource_group.load_test.location
  address_space       = ["10.40.0.0/22"]

  tags = local.tags
}

resource "azurerm_subnet" "weu_load_test" {
  name                 = "${local.project}-load-test-snet-01"
  resource_group_name  = azurerm_resource_group.load_test.name
  virtual_network_name = azurerm_virtual_network.weu_load_test.name
  address_prefixes     = ["10.40.0.0/27"]
}

resource "azurerm_virtual_network_peering" "weu_load_test" {
  name                      = format("%s-to-%s-peer", azurerm_virtual_network.weu_load_test.name, data.azurerm_virtual_network.weu_common.name)
  resource_group_name       = azurerm_virtual_network.weu_load_test.resource_group_name
  virtual_network_name      = azurerm_virtual_network.weu_load_test.name
  remote_virtual_network_id = data.azurerm_virtual_network.weu_common.id

  allow_virtual_network_access = false
}

resource "azurerm_virtual_network_peering" "weu_common" {
  name                      = format("%s-to-%s-peer", data.azurerm_virtual_network.weu_common.name, azurerm_virtual_network.weu_load_test.name)
  resource_group_name       = data.azurerm_virtual_network.weu_common.resource_group_name
  virtual_network_name      = data.azurerm_virtual_network.weu_common.name
  remote_virtual_network_id = azurerm_virtual_network.weu_load_test.id

  allow_virtual_network_access = true
}
