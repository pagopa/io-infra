#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "appbackend-REDIS-PASSWORD" {
  name         = "appbackend-REDIS-PASSWORD"
  value        = data.azurerm_redis_cache.redis_common.primary_access_key
  key_vault_id = var.key_vault_common.id
  content_type = "string"
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "appbackend-SPID-LOG-STORAGE" {
  name         = "appbackend-SPID-LOG-STORAGE"
  value        = data.azurerm_storage_account.logs.primary_connection_string
  key_vault_id = var.key_vault_common.id
  content_type = "string"
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "appbackend-PUSH-NOTIFICATIONS-STORAGE" {
  name         = "appbackend-PUSH-NOTIFICATIONS-STORAGE"
  value        = data.azurerm_storage_account.push_notifications_storage.primary_connection_string
  key_vault_id = var.key_vault_common.id
  content_type = "string"
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "appbackend-NORIFICATIONS-STORAGE" {
  name         = "appbackend-NORIFICATIONS-STORAGE"
  value        = data.azurerm_storage_account.notifications.primary_connection_string
  key_vault_id = var.key_vault_common.id
  content_type = "string"
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "appbackend-USERS-LOGIN-STORAGE" {
  name         = "appbackend-USERS-LOGIN-STORAGE"
  value        = data.azurerm_storage_account.logs.primary_connection_string
  key_vault_id = var.key_vault_common.id
  content_type = "string"
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "appbackend_LOLLIPOP_ASSERTIONS_STORAGE" {
  name         = "appbackend-LOLLIPOP-ASSERTIONS-STORAGE"
  value        = data.azurerm_storage_account.lollipop_assertions_storage.primary_connection_string
  key_vault_id = var.key_vault_common.id
  content_type = "string"
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "appbackend_THIRD_PARTY_CONFIG_LIST" {
  name         = "appbackend-THIRD-PARTY-CONFIG-LIST"
  value        = local.app_backend.app_settings_common.THIRD_PARTY_CONFIG_LIST
  key_vault_id = var.key_vault_common.id
  content_type = "string"
}