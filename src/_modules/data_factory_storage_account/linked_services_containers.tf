resource "azurerm_data_factory_linked_service_azure_blob_storage" "linked_service_container" {
  for_each        = var.source_types.blob ? [1] : []
  name            = "${module.naming_convention.prefix}-adf-${var.source_storage_account.name}-st-${module.naming_convention.suffix}"
  data_factory_id = var.data_factory.id

  service_endpoint = "https://${var.source_storage_account.id}.blob.core.windows.net"

  use_managed_identity = true
}