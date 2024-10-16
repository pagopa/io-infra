resource "azurerm_data_factory_linked_service_azure_blob_storage" "source_linked_service_blob" {
  for_each        = var.what_to_migrate.blob.enabled ? [1] : []
  name            = "${module.naming_convention.prefix}-adf-${var.storage_accounts.source.name}-blob-${module.naming_convention.suffix}"
  data_factory_id = var.data_factory.id

  service_endpoint = "https://${data.azurerm_storage_account.source.id}.blob.core.windows.net"

  use_managed_identity = true
}

resource "azurerm_data_factory_linked_service_azure_blob_storage" "target_linked_service_blob" {
  for_each        = var.what_to_migrate.blob.enabled ? [1] : []
  name            = "${module.naming_convention.prefix}-adf-${var.storage_accounts.target.name}-blob-${module.naming_convention.suffix}"
  data_factory_id = var.data_factory.id

  service_endpoint = "https://${data.azurerm_storage_account.target.id}.blob.core.windows.net"

  use_managed_identity = true
}