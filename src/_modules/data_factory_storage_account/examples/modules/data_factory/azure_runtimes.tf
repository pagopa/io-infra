resource "azurerm_data_factory_integration_runtime_azure" "azure_runtime" {
  for_each        = var.azure_runtimes
  name                = "${local.prefix}-${local.env_short}-${local.region}-${local.domain}-${local.appname}-${local.azure_data_factory_azure_runtime}-${each.value.name}"
  data_factory_id = azurerm_data_factory.data_factory[each.value.data_factory].id
  location        = each.value.location
}
