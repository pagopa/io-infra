#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "appbackend-REDIS-PASSWORD" {
  count        = var.index == 1 ? 1 : 0
  name         = "appbackend-REDIS-PASSWORD"
  value        = var.redis_common.primary_access_key
  key_vault_id = var.key_vault_common.id
  content_type = "string"
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "appbackend-SPID-LOG-STORAGE" {
  count        = var.index == 1 ? 1 : 0
  name         = "appbackend-SPID-LOG-STORAGE"
  value        = data.azurerm_storage_account.logs.primary_connection_string
  key_vault_id = var.key_vault_common.id
  content_type = "string"
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "appbackend-PUSH-NOTIFICATIONS-STORAGE" {
  count        = var.index == 1 ? 1 : 0
  name         = "appbackend-PUSH-NOTIFICATIONS-STORAGE"
  value        = data.azurerm_storage_account.push_notifications_storage.primary_connection_string
  key_vault_id = var.key_vault_common.id
  content_type = "string"
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "appbackend-NORIFICATIONS-STORAGE" {
  count        = var.index == 1 ? 1 : 0
  name         = "appbackend-NORIFICATIONS-STORAGE"
  value        = data.azurerm_storage_account.notifications.primary_connection_string
  key_vault_id = var.key_vault_common.id
  content_type = "string"
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "appbackend-USERS-LOGIN-STORAGE" {
  count        = var.index == 1 ? 1 : 0
  name         = "appbackend-USERS-LOGIN-STORAGE"
  value        = data.azurerm_storage_account.logs.primary_connection_string
  key_vault_id = var.key_vault_common.id
  content_type = "string"
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "appbackend_LOLLIPOP_ASSERTIONS_STORAGE" {
  count        = var.index == 1 ? 1 : 0 # only for the first non-li backend
  name         = "appbackend-LOLLIPOP-ASSERTIONS-STORAGE"
  value        = data.azurerm_storage_account.lollipop_assertions_storage.primary_connection_string
  key_vault_id = var.key_vault_common.id
  content_type = "string"
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "appbackend_THIRD_PARTY_CONFIG_LIST" {
  count        = var.index == 1 ? 1 : 0
  name         = "appbackend-THIRD-PARTY-CONFIG-LIST"
  value        = local.app_settings_common.THIRD_PARTY_CONFIG_LIST
  key_vault_id = var.key_vault_common.id
  content_type = "string"
}
