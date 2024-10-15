resource "azurerm_data_factory_linked_service_azure_table_storage" "linked_service_table" {
  for_each        = var.linked_services_tables
  name                = "${local.prefix}-${local.env_short}-${local.region}-${local.domain}-${local.appname}-${local.azure_data_factory_linked_service_table}-${each.value.name}"
  data_factory_id = azurerm_data_factory.data_factory[each.value.data_factory].id

  connection_string = each.value.connection_string
}