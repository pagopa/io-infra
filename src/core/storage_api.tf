module "storage_api" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v7.28.0"

  name                             = replace("${local.project}stapi", "-", "")
  account_kind                     = "StorageV2"
  account_tier                     = "Standard"
  access_tier                      = "Hot"
  account_replication_type         = "GRS"
  resource_group_name              = azurerm_resource_group.rg_internal.name
  location                         = azurerm_resource_group.rg_internal.location
  advanced_threat_protection       = true
  allow_nested_items_to_be_public  = false
  cross_tenant_replication_enabled = true
  public_network_access_enabled    = true

  blob_versioning_enabled              = true
  blob_container_delete_retention_days = 7
  blob_delete_retention_days           = 7
  blob_change_feed_enabled             = true
  blob_change_feed_retention_in_days   = 10
  blob_storage_policy = {
    enable_immutability_policy = false
    blob_restore_policy_days   = 6
  }

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

# Storage replica
module "storage_api_replica" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v7.28.0"

  name                             = replace("${local.project}stapireplica", "-", "")
  account_kind                     = "StorageV2"
  account_tier                     = "Standard"
  access_tier                      = "Hot"
  account_replication_type         = "LRS"
  resource_group_name              = azurerm_resource_group.rg_internal.name
  location                         = azurerm_resource_group.rg_internal.location
  advanced_threat_protection       = true
  allow_nested_items_to_be_public  = false
  cross_tenant_replication_enabled = true
  public_network_access_enabled    = true

  blob_versioning_enabled              = true
  blob_container_delete_retention_days = 7

  network_rules = {
    default_action = "Deny"
    ip_rules       = []
    bypass = [
      "Logging",
      "Metrics",
      "AzureServices",
    ]
    virtual_network_subnet_ids = []
  }

  tags = var.tags
}

module "storage_api_object_replication_to_replica" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_object_replication?ref=v7.28.0"

  source_storage_account_id      = module.storage_api.id
  destination_storage_account_id = module.storage_api_replica.id

  rules = [{
    source_container_name      = azurerm_storage_container.storage_api_message_content.name
    destination_container_name = azurerm_storage_container.storage_api_message_content.name
    copy_blobs_created_after   = "Everything"
  }]
}

moved {
  from = module.io_apist_replica.azurerm_storage_object_replication.this
  to   = module.storage_api_object_replication_to_replica.azurerm_storage_object_replication.this
}

#-----------------------------------------------------

data "azurerm_storage_account" "storage_apievents" {
  name                = replace(format("%s-stapievents", local.project), "-", "")
  resource_group_name = azurerm_resource_group.rg_internal.name
}

resource "azurerm_storage_queue" "storage_account_apievents_events_queue" {
  name                 = "events"
  storage_account_name = data.azurerm_storage_account.storage_apievents.name
}
