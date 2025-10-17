resource "azurerm_storage_account" "iopitndataexportst01" {

  count = var.location == "italynorth" ? 1 : 0

  name                     = replace("${var.project}dataexportst01", "-", "")
  resource_group_name      = var.resource_group_operations
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "ZRS" # GZRS not available at the moment in ITN

  public_network_access_enabled    = true
  shared_access_key_enabled        = true
  allow_nested_items_to_be_public  = false
  cross_tenant_replication_enabled = true

  tags = var.tags
}

resource "azurerm_storage_account" "iopitnlogst01" {

  count = var.location == "italynorth" ? 1 : 0

  name                     = replace("${var.project}logst01", "-", "")
  resource_group_name      = var.resource_group_operations
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "ZRS" # GZRS not available at the moment in ITN

  public_network_access_enabled    = true
  allow_nested_items_to_be_public  = true
  large_file_share_enabled         = true
  cross_tenant_replication_enabled = true

  blob_properties {
    versioning_enabled  = true
    change_feed_enabled = true
  }

  tags = var.tags
}

resource "azurerm_storage_account" "iopitncdnassetsst01" {

  count = var.location == "italynorth" ? 1 : 0

  name                     = replace("${var.project}cdnassetsst01", "-", "")
  resource_group_name      = var.resource_group_operations
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "ZRS" # GZRS not available at the moment in ITN

  public_network_access_enabled    = true
  allow_nested_items_to_be_public  = true
  large_file_share_enabled         = true
  cross_tenant_replication_enabled = true

  blob_properties {
    versioning_enabled  = true
    change_feed_enabled = false
  }

  tags = var.tags
}