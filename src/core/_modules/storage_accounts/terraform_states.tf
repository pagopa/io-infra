resource "azurerm_storage_account" "terraform" {
  name                = replace("${var.project}tfst001", "-", "")
  resource_group_name = var.resource_group_name
  location            = var.location

  account_tier             = "Standard"
  access_tier              = "Hot"
  account_kind             = "StorageV2"
  account_replication_type = "ZRS"

  allow_nested_items_to_be_public  = false
  cross_tenant_replication_enabled = false

  tags = var.tags
}

resource "azurerm_storage_account" "tfinfprodio" {
  name                = replace("${var.project}tfinfprodio", "-", "")
  resource_group_name = var.resource_group_name
  location            = var.location

  account_tier             = "Standard"
  access_tier              = "Hot"
  account_kind             = "StorageV2"
  account_replication_type = "ZRS" # GZRS not available at the moment in ITN

  allow_nested_items_to_be_public  = false
  cross_tenant_replication_enabled = false
  large_file_share_enabled         = false

  blob_properties {
    versioning_enabled            = true
    change_feed_enabled           = true
    change_feed_retention_in_days = 30

    delete_retention_policy {
      days                     = 30
      permanent_delete_enabled = false
    }

    container_delete_retention_policy {
      days = 30
    }

  }

  tags = var.tags
}

resource "azurerm_storage_account" "tfappprodio" {
  name                = replace("${var.project}tfappprodio", "-", "")
  resource_group_name = var.resource_group_name
  location            = var.location

  account_tier             = "Standard"
  access_tier              = "Hot"
  account_kind             = "StorageV2"
  account_replication_type = "ZRS" # GZRS not available at the moment in ITN

  allow_nested_items_to_be_public  = false
  cross_tenant_replication_enabled = false
  large_file_share_enabled         = false

  blob_properties {
    versioning_enabled            = true
    change_feed_enabled           = true
    change_feed_retention_in_days = 30

    delete_retention_policy {
      days                     = 30
      permanent_delete_enabled = false
    }

    container_delete_retention_policy {
      days = 30
    }

  }

  tags = var.tags
}