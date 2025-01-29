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

resource "azurerm_storage_container" "bonus_activations_itn_01" {
  name                  = "bonus-activations"
  storage_account_id    = azurerm_storage_account.bonus_backup_itn_01.id
  container_access_type = "private"
}

resource "azurerm_storage_container" "bonus_activations_gwc_01" {
  name                  = "bonus-activations"
  storage_account_id    = azurerm_storage_account.bonus_backup_gwc_01.id
  container_access_type = "private"
}

resource "azurerm_storage_container" "bonus_leases_itn_01" {
  name                  = "bonus-leases"
  storage_account_id    = azurerm_storage_account.bonus_backup_itn_01.id
  container_access_type = "private"
}

resource "azurerm_storage_container" "bonus_leases_gwc_01" {
  name                  = "bonus-leases"
  storage_account_id    = azurerm_storage_account.bonus_backup_gwc_01.id
  container_access_type = "private"
}

resource "azurerm_storage_container" "bonus_processing_itn_01" {
  name                  = "bonus-processing"
  storage_account_id    = azurerm_storage_account.bonus_backup_itn_01.id
  container_access_type = "private"
}

resource "azurerm_storage_container" "bonus_processing_gwc_01" {
  name                  = "bonus-processing"
  storage_account_id    = azurerm_storage_account.bonus_backup_gwc_01.id
  container_access_type = "private"
}

resource "azurerm_storage_container" "change_feed_leases_itn_01" {
  name                  = "change-feed-leases"
  storage_account_id    = azurerm_storage_account.bonus_backup_itn_01.id
  container_access_type = "private"
}

resource "azurerm_storage_container" "change_feed_leases_gwc_01" {
  name                  = "change-feed-leases"
  storage_account_id    = azurerm_storage_account.bonus_backup_gwc_01.id
  container_access_type = "private"
}

resource "azurerm_storage_container" "eligibility_checks_itn_01" {
  name                  = "eligibility-checks"
  storage_account_id    = azurerm_storage_account.bonus_backup_itn_01.id
  container_access_type = "private"
}

resource "azurerm_storage_container" "eligibility_checks_gwc_01" {
  name                  = "eligibility-checks"
  storage_account_id    = azurerm_storage_account.bonus_backup_gwc_01.id
  container_access_type = "private"
}

resource "azurerm_storage_container" "user_bonuses_itn_01" {
  name                  = "user-bonuses"
  storage_account_id    = azurerm_storage_account.bonus_backup_itn_01.id
  container_access_type = "private"
}

resource "azurerm_storage_container" "user_bonuses_gwc_01" {
  name                  = "user-bonuses"
  storage_account_id    = azurerm_storage_account.bonus_backup_gwc_01.id
  container_access_type = "private"
}

