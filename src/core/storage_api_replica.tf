data "azurerm_key_vault_secret" "backup_storage_id" {
  name         = "backup-storage-id"
  key_vault_id = data.azurerm_key_vault.common.id
}

#-----------------------------------------------------

module "io_apist_replica" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_object_replication?ref=v4.1.16"

  source_storage_account_id      = data.azurerm_storage_account.api.id
  destination_storage_account_id = data.azurerm_key_vault_secret.backup_storage_id.value

  rules = [{
    source_container_name      = "message-content"
    destination_container_name = "message-content"
    copy_blobs_created_after   = "Everything"
  }]
}
