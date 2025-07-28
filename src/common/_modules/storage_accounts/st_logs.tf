resource "azurerm_storage_account" "logs" {
  count = var.location == "westeurope" ? 1 : 0

  name                = "iopstlogs"
  resource_group_name = "io-p-rg-operations"

  location                 = "westeurope"
  account_tier             = "Standard"
  account_replication_type = "GZRS"

  blob_properties {
    versioning_enabled  = true
    change_feed_enabled = true
  }

  tags = var.tags
}
