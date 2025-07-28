resource "azurerm_storage_account" "logs" {
  name                = "iopstlogs"
  resource_group_name = "io-p-rg-operations"

  location                 = "westeurope"
  account_tier             = "Standard"
  account_replication_type = "GZRS"

  allow_nested_items_to_be_public = false

  blob_properties {
    versioning_enabled = true
  }

  tags = var.tags
}
