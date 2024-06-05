output "load_test_weu_common" {
  value = {
    id = azurerm_load_test.weu_common.id
    name = azurerm_load_test.weu_common.name
    location = azurerm_load_test.weu_common.location
    principal_id = azurerm_load_test.weu_common.identity[0].principal_id
  }
}
