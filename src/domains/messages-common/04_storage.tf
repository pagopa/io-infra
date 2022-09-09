data "azurerm_storage_account" "api_storage" {
  name                = replace(format("%s-stapi", local.product), "-", "")
  resource_group_name = format("%s-rg-internal", local.product)
}

data "azurerm_storage_account" "notifications_storage" {
  name                = replace(format("%s-stnotifications", local.product), "-", "")
  resource_group_name = format("%s-rg-internal", local.product)
}

resource "azurerm_key_vault_secret" "notifications_storage_connection_string" {
  name         = "${data.azurerm_storage_account.notifications_storage.name}-connection-string"
  value        = data.azurerm_storage_account.notifications_storage.primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "api_storage_connection_string" {
  name         = "${data.azurerm_storage_account.api_storage.name}-connection-string"
  value        = data.azurerm_storage_account.api_storage.primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}
