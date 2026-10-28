#trivy:ignore:AZU-0057
#trivy:ignore:AZU-0058
#trivy:ignore:AZU-0060
#trivy:ignore:AZU-0061
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

#trivy:ignore:AZU-0057
#trivy:ignore:AZU-0058
#trivy:ignore:AZU-0060
#trivy:ignore:AZU-0061
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

resource "azurerm_monitor_diagnostic_setting" "bonus_backup_itn_01_diagnostic_setting" {

  depends_on = [azurerm_storage_account.bonus_backup_itn_01]

  target_resource_id         = "${azurerm_storage_account.bonus_backup_itn_01.id}/blobServices/default"
  name                       = replace("${local.project}backupst01", "-", "")
  log_analytics_workspace_id = local.platform_observability.monitoring_italynorth.log.id
  storage_account_id         = local.platform_observability.storage_accounts.itn.logs.id

  enabled_log {
    category = "StorageWrite"
  }

  enabled_log {
    category = "StorageDelete"
  }

  enabled_metric {
    category = "AllMetrics"
  }
}

resource "azurerm_monitor_diagnostic_setting" "bonus_backup_gwc_01_diagnostic_setting" {

  depends_on = [azurerm_storage_account.bonus_backup_gwc_01]

  target_resource_id         = "${azurerm_storage_account.bonus_backup_gwc_01.id}/blobServices/default"
  name                       = replace("${local.secondary_project}backupst01", "-", "")
  log_analytics_workspace_id = local.platform_observability.monitoring_italynorth.log.id
  storage_account_id         = local.platform_observability.storage_accounts.itn.logs.id

  enabled_log {
    category = "StorageWrite"
  }

  enabled_log {
    category = "StorageDelete"
  }

  enabled_metric {
    category = "AllMetrics"
  }
}