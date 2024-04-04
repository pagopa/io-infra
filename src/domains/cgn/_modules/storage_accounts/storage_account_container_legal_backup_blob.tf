resource "azurerm_storage_container" "storage_container_legal_backup" {
  name                  = "cgn-legalbackup-blob"
  storage_account_name  = module.storage_account_legal_backup.name
  container_access_type = "private"
}
