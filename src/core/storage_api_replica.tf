module "storage_account_api_replica" {
  source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v1.0.60"

  name                       = replace(format("%s-stapi-replica", local.project), "-", "")
  account_kind               = "StorageV2"
  account_tier               = "Standard"
  account_replication_type   = "LRS"
  access_tier                = "Hot"
  resource_group_name        = azurerm_resource_group.rg_internal.name
  location                   = var.location
  advanced_threat_protection = false

  tags = var.tags
}

resource "azurerm_storage_container" "container_replica_message_content" {
  name                  = "message-content"
  storage_account_name  = module.storage_account_api_replica.name
  container_access_type = "private"
}

data "azurerm_storage_account" "api" {
  name                = "iopstapi"
  resource_group_name = azurerm_resource_group.rg_internal.name
}


module "io_apist_replica" {
  source = "git::https://github.com/pagopa/azurerm.git//storage_object_replication?ref=v2.0.6"

  source_storage_account_id      = data.azurerm_storage_account.api.id
  destination_storage_account_id = module.storage_account_api_replica.id

  rules = [{
    source_container_name      = "message-content"
    destination_container_name = "message-content"
    copy_blobs_created_after   = "Everything"
  }]

}
