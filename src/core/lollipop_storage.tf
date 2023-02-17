resource "azurerm_storage_queue" "storage_account_lollipop_revoke_queue" {
  name                 = "pubkeys-revoke"
  storage_account_name = data.azurerm_storage_account.storage_lollipop.name
}

