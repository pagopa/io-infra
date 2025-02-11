resource "azurerm_role_assignment" "blob_data_owner_itn_01" {
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = data.azuread_group.admin.object_id
  scope                = azurerm_storage_account.bonus_backup_itn_01.id
}

resource "azurerm_role_assignment" "blob_data_owner_gwc_01" {
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = data.azuread_group.admin.object_id
  scope                = azurerm_storage_account.bonus_backup_gwc_01.id
}

resource "azurerm_role_assignment" "queue_data_contributor_itn_01" {
  role_definition_name = "Storage Queue Data Contributor"
  principal_id         = data.azuread_group.admin.object_id
  scope                = azurerm_storage_account.bonus_backup_itn_01.id
}

resource "azurerm_role_assignment" "queue_data_contributor_gwc_01" {
  role_definition_name = "Storage Queue Data Contributor"
  principal_id         = data.azuread_group.admin.object_id
  scope                = azurerm_storage_account.bonus_backup_gwc_01.id
}

resource "azurerm_role_assignment" "table_data_contributor_itn_01" {
  role_definition_name = "Storage Table Data Contributor"
  principal_id         = data.azuread_group.admin.object_id
  scope                = azurerm_storage_account.bonus_backup_itn_01.id
}

resource "azurerm_role_assignment" "table_data_contributor_gwc_01" {
  role_definition_name = "Storage Table Data Contributor"
  principal_id         = data.azuread_group.admin.object_id
  scope                = azurerm_storage_account.bonus_backup_gwc_01.id
}
