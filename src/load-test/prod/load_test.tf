resource "azurerm_load_test" "weu_common" {
  name                = "${local.project}-common-lt-01"
  resource_group_name = azurerm_resource_group.load_test.name
  location            = azurerm_resource_group.load_test.location

  description = "A Load Test resource with access to IO Prod environment to test private components"

  identity {
    type = "SystemAssigned"
  }

  tags = local.tags
}
