output "storage_account_primary" {
  value = {
    id                  = azurerm_storage_account.bonus_backup_itn_01.id
    name                = azurerm_storage_account.bonus_backup_itn_01.name
    resource_group_name = azurerm_storage_account.bonus_backup_itn_01.resource_group_name
  }
}

output "storage_account_secondary" {
  value = {
    id                  = azurerm_storage_account.bonus_backup_gwc_01.id
    name                = azurerm_storage_account.bonus_backup_gwc_01.name
    resource_group_name = azurerm_storage_account.bonus_backup_gwc_01.resource_group_name
  }
}
