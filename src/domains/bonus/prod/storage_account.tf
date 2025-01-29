resource "azurerm_storage_account" "bonus_backup_itn_01" {
  name                = replace("${local.project}backupst01", "-", "")
  resource_group_name = azurerm_resource_group.rg_itn_01.name
  location            = local.location

  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "ZRS"
  access_tier              = "Cool"

  public_network_access_enabled = true

  shared_access_key_enabled       = false
  default_to_oauth_authentication = true

  blob_properties {
    versioning_enabled       = true
    change_feed_enabled      = true
    last_access_time_enabled = true

    delete_retention_policy {
      days = 7
    }

    restore_policy {
      days = 5
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
  account_replication_type = "ZRS"
  access_tier              = "Cool"

  public_network_access_enabled = true

  shared_access_key_enabled       = false
  default_to_oauth_authentication = true

  blob_properties {
    versioning_enabled       = true
    change_feed_enabled      = true
    last_access_time_enabled = true

    delete_retention_policy {
      days = 7
    }

    restore_policy {
      days = 5
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
    source_container_name      = azurerm_storage_container.bonus_activations_itn_01.name
    destination_container_name = azurerm_storage_container.bonus_activations_gwc_01.name
    copy_blobs_created_after   = "Everything"
  }

  rules {
    source_container_name      = azurerm_storage_container.bonus_leases_itn_01.name
    destination_container_name = azurerm_storage_container.bonus_leases_gwc_01.name
    copy_blobs_created_after   = "Everything"
  }

  rules {
    source_container_name      = azurerm_storage_container.bonus_processing_itn_01.name
    destination_container_name = azurerm_storage_container.bonus_processing_gwc_01.name
    copy_blobs_created_after   = "Everything"
  }

  rules {
    source_container_name      = azurerm_storage_container.change_feed_leases_itn_01.name
    destination_container_name = azurerm_storage_container.change_feed_leases_gwc_01.name
    copy_blobs_created_after   = "Everything"
  }

  rules {
    source_container_name      = azurerm_storage_container.eligibility_checks_itn_01.name
    destination_container_name = azurerm_storage_container.eligibility_checks_gwc_01.name
    copy_blobs_created_after   = "Everything"
  }

  rules {
    source_container_name      = azurerm_storage_container.user_bonuses_itn_01.name
    destination_container_name = azurerm_storage_container.user_bonuses_gwc_01.name
    copy_blobs_created_after   = "Everything"
  }
}
