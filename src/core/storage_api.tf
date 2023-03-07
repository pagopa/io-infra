module "storage_api" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v5.6.0"

  name                            = replace("${local.project}stapi", "-", "")
  account_kind                    = "StorageV2"
  account_tier                    = "Standard"
  access_tier                     = "Hot"
  account_replication_type        = "GRS"
  resource_group_name             = azurerm_resource_group.rg_internal.name
  location                        = azurerm_resource_group.rg_internal.location
  advanced_threat_protection      = true
  allow_nested_items_to_be_public = false

  blob_versioning_enabled              = true
  blob_container_delete_retention_days = 7
  blob_delete_retention_days           = 7
  blob_change_feed_enabled             = true
  blob_change_feed_retention_in_days   = 10
  blob_restore_policy_days             = 6

  tags = var.tags
}

resource "azurerm_storage_container" "storage_api_message_content" {
  name                  = "message-content"
  storage_account_name  = module.storage_api.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "storage_api_cached" {
  name                  = "cached"
  storage_account_name  = module.storage_api.name
  container_access_type = "private"
}

resource "azurerm_storage_table" "storage_api_subscriptionsfeedbyday" {
  name                 = "SubscriptionsFeedByDay"
  storage_account_name = module.storage_api.name
}

resource "azurerm_storage_table" "storage_api_faileduserdataprocessing" {
  name                 = "FailedUserDataProcessing"
  storage_account_name = module.storage_api.name
}

resource "azurerm_storage_table" "storage_api_validationtokens" {
  name                 = "ValidationTokens"
  storage_account_name = module.storage_api.name
}

# storage replica
data "azurerm_key_vault_secret" "backup_storage_id" {
  name         = "backup-storage-id"
  key_vault_id = module.key_vault_common.id
}

#-----------------------------------------------------

module "io_apist_replica" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_object_replication?ref=v4.1.15"

  source_storage_account_id      = module.storage_api.id
  destination_storage_account_id = data.azurerm_key_vault_secret.backup_storage_id.value

  rules = [{
    source_container_name      = "message-content"
    destination_container_name = "message-content"
    copy_blobs_created_after   = "Everything"
  }]
}

data "azurerm_storage_account" "storage_apievents" {
  name                = replace(format("%s-stapievents", local.project), "-", "")
  resource_group_name = azurerm_resource_group.rg_internal.name
}

resource "azurerm_storage_queue" "storage_account_apievents_events_queue" {
  name                 = "events"
  storage_account_name = data.azurerm_storage_account.storage_apievents.name
}
