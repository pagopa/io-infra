resource "azurerm_storage_account" "app" {
  count = var.location == "westeurope" ? 1 : 0

  name                = "iopstapp"
  resource_group_name = "io-p-rg-internal"

  location                 = "westeurope"
  account_tier             = "Standard"
  account_replication_type = "GZRS"

  allow_nested_items_to_be_public = false

  blob_properties {
    versioning_enabled = true
  }

  tags = var.tags
}
