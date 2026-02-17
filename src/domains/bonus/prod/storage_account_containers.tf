resource "azurerm_storage_container" "bonus_itn_01" {
  name                  = "bonus"
  storage_account_id    = azurerm_storage_account.bonus_backup_itn_01.id
  container_access_type = "private"
}

resource "azurerm_storage_container" "bonus_gwc_01" {
  name                  = "bonus"
  storage_account_id    = azurerm_storage_account.bonus_backup_gwc_01.id
  container_access_type = "private"
}

resource "azurerm_storage_container" "redeemed_requests_itn_01" {
  name                  = "redeemed-requests"
  storage_account_id    = azurerm_storage_account.bonus_backup_itn_01.id
  container_access_type = "private"
}

resource "azurerm_storage_container" "redeemed_requests_gwc_01" {
  name                  = "redeemed-requests"
  storage_account_id    = azurerm_storage_account.bonus_backup_gwc_01.id
  container_access_type = "private"
}

resource "azurerm_storage_container" "cosmosdb_itn_01" {
  name                  = "cosmosdb"
  storage_account_id    = azurerm_storage_account.bonus_backup_itn_01.id
  container_access_type = "private"
}

resource "azurerm_storage_container" "cosmosdb_gwc_01" {
  name                  = "cosmosdb"
  storage_account_id    = azurerm_storage_account.bonus_backup_gwc_01.id
  container_access_type = "private"
}
