resource "azurerm_storage_table" "adelogs_itn_01" {
  name                 = "adelogs"
  storage_account_name = azurerm_storage_account.bonus_backup_itn_01.name
}

resource "azurerm_storage_table" "adelogs_gwc_01" {
  name                 = "adelogs"
  storage_account_name = azurerm_storage_account.bonus_backup_gwc_01.name
}

resource "azurerm_storage_table" "bonusactivations_itn_01" {
  name                 = "bonusactivations"
  storage_account_name = azurerm_storage_account.bonus_backup_itn_01.name
}

resource "azurerm_storage_table" "bonusactivations_gwc_01" {
  name                 = "bonusactivations"
  storage_account_name = azurerm_storage_account.bonus_backup_gwc_01.name
}

resource "azurerm_storage_table" "bonusleasebindings_itn_01" {
  name                 = "bonusleasebindings"
  storage_account_name = azurerm_storage_account.bonus_backup_itn_01.name
}

resource "azurerm_storage_table" "bonusleasebindings_gwc_01" {
  name                 = "bonusleasebindings"
  storage_account_name = azurerm_storage_account.bonus_backup_gwc_01.name
}

resource "azurerm_storage_table" "eligibilitychecks_itn_01" {
  name                 = "eligibilitychecks"
  storage_account_name = azurerm_storage_account.bonus_backup_itn_01.name
}

resource "azurerm_storage_table" "eligibilitychecks_gwc_01" {
  name                 = "eligibilitychecks"
  storage_account_name = azurerm_storage_account.bonus_backup_gwc_01.name
}

resource "azurerm_storage_table" "inpslogs_itn_01" {
  name                 = "inpslogs"
  storage_account_name = azurerm_storage_account.bonus_backup_itn_01.name
}

resource "azurerm_storage_table" "inpslogs_gwc_01" {
  name                 = "inpslogs"
  storage_account_name = azurerm_storage_account.bonus_backup_gwc_01.name
}

resource "azurerm_storage_table" "opsActiveBonusSentMsgStatus_itn_01" {
  name                 = "opsActiveBonusSentMsgStatus"
  storage_account_name = azurerm_storage_account.bonus_backup_itn_01.name
}

resource "azurerm_storage_table" "opsActiveBonusSentMsgStatus_gwc_01" {
  name                 = "opsActiveBonusSentMsgStatus"
  storage_account_name = azurerm_storage_account.bonus_backup_gwc_01.name
}

resource "azurerm_storage_table" "redeemederrors_itn_01" {
  name                 = "redeemederrors"
  storage_account_name = azurerm_storage_account.bonus_backup_itn_01.name
}

resource "azurerm_storage_table" "redeemederrors_gwc_01" {
  name                 = "redeemederrors"
  storage_account_name = azurerm_storage_account.bonus_backup_gwc_01.name
}
