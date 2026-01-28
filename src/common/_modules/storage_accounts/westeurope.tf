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

resource "azurerm_storage_account" "exportdata_weu_01" {
  count = var.location == "westeurope" ? 1 : 0

  name                     = replace("${var.project}stexportdata", "-", "")
  resource_group_name      = var.resource_group_operations
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GZRS"

  public_network_access_enabled    = true
  shared_access_key_enabled        = true
  allow_nested_items_to_be_public  = false
  cross_tenant_replication_enabled = false

  tags = var.tags
}

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
