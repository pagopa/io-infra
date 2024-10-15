resource "azurerm_data_factory_linked_service_azure_blob_storage" "linked_service_container" {
  for_each        = var.linked_services
  name                = "${local.prefix}-${local.env_short}-${local.region}-${local.domain}-${local.appname}-${local.azure_data_factory_linked_service_container}-${each.value.name}"
  data_factory_id = azurerm_data_factory.data_factory[each.value.data_factory].id

  service_endpoint = "https://${each.value.storage_account}.blob.core.windows.net"

  use_managed_identity = true
}