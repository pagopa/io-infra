resource "azurerm_storage_account" "bonus_backup_itn_01" {
  name                = replace("${local.project}backupst01", "-", "")
  resource_group_name = azurerm_resource_group.rg_itn_01.name
  location            = local.location

  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "ZRS"
  # access_tier              = "Cold" # not supported by the provider

  public_network_access_enabled = false

  network_rules {
    default_action = "Deny"
    bypass         = ["Logging", "Metrics", "AzureServices"]
  }

  allowed_copy_scope              = "AAD"
  shared_access_key_enabled       = true # not supported for tables, plan throws an error
  default_to_oauth_authentication = true
  allow_nested_items_to_be_public = false

  blob_properties {
    versioning_enabled       = true
    change_feed_enabled      = true
    last_access_time_enabled = true

    delete_retention_policy {
      days = 7
    }

    container_delete_retention_policy {
      days = 10
    }
  }

  tags = local.tags
}

resource "azurerm_storage_account" "bonus_backup_gwc_01" {
  name                = replace("${local.secondary_project}backupst01", "-", "")
  resource_group_name = azurerm_resource_group.rg_itn_01.name
  location            = local.secondary_location

  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  # access_tier              = "Cold" # not supported by the provider

  public_network_access_enabled = false

  network_rules {
    default_action = "Deny"
    bypass         = ["Logging", "Metrics", "AzureServices"]
  }

  allowed_copy_scope              = "AAD"
  shared_access_key_enabled       = true # not supported for tables, plan throws an error
  default_to_oauth_authentication = true
  allow_nested_items_to_be_public = false

  blob_properties {
    versioning_enabled       = true
    change_feed_enabled      = true
    last_access_time_enabled = true

    delete_retention_policy {
      days = 7
    }

    container_delete_retention_policy {
      days = 10
    }
  }

  tags = local.tags
}

resource "azurerm_storage_object_replication" "itn_01_to_gwc_01" {
  source_storage_account_id      = azurerm_storage_account.bonus_backup_itn_01.id
  destination_storage_account_id = azurerm_storage_account.bonus_backup_gwc_01.id

  rules {
    source_container_name      = azurerm_storage_container.bonus_itn_01.name
    destination_container_name = azurerm_storage_container.bonus_gwc_01.name
    copy_blobs_created_after   = "Everything"
  }

  rules {
    source_container_name      = azurerm_storage_container.redeemed_requests_itn_01.name
    destination_container_name = azurerm_storage_container.redeemed_requests_gwc_01.name
    copy_blobs_created_after   = "Everything"
  }

  rules {
    source_container_name      = azurerm_storage_container.cosmosdb_itn_01.name
    destination_container_name = azurerm_storage_container.cosmosdb_gwc_01.name
    copy_blobs_created_after   = "Everything"
  }
}

resource "azurerm_management_lock" "st_itn_01" {
  name       = azurerm_storage_account.bonus_backup_itn_01.name
  scope      = azurerm_storage_account.bonus_backup_itn_01.id
  lock_level = "ReadOnly"
  notes      = "Data is immutable and offline, and should not be read or modified"
}

resource "azurerm_management_lock" "st_gwc_01" {
  name       = azurerm_storage_account.bonus_backup_gwc_01.name
  scope      = azurerm_storage_account.bonus_backup_gwc_01.id
  lock_level = "ReadOnly"
  notes      = "Data is immutable and offline, and should not be read or modified"
}
