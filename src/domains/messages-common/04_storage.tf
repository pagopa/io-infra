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

resource "azurerm_resource_group" "notifications_rg" {
  name     = format("%s-notifications-rg", local.project)
  location = var.location

  tags = var.tags
}

module "push_notifications_storage" {
  source                        = "git::https://github.com/pagopa/terraform-azurerm-v3//storage_account?ref=v7.69.1"
  name                          = replace(format("%s-notifst", local.project), "-", "")
  domain                        = upper(var.domain)
  account_kind                  = "StorageV2"
  account_tier                  = "Standard"
  access_tier                   = "Hot"
  account_replication_type      = "ZRS"
  resource_group_name           = azurerm_resource_group.notifications_rg.name
  location                      = azurerm_resource_group.notifications_rg.location
  advanced_threat_protection    = true
  public_network_access_enabled = true

  tags = var.tags
}

resource "azurerm_storage_queue" "push_notifications_queue" {
  name                 = "push-notifications"
  storage_account_name = module.push_notifications_storage.name
}

module "push_notif_beta_storage" {
  source                        = "git::https://github.com/pagopa/terraform-azurerm-v3//storage_account?ref=v7.69.1"
  name                          = replace(format("%s-betauserst", local.project), "-", "")
  domain                        = upper(var.domain)
  account_kind                  = "StorageV2"
  account_tier                  = "Standard"
  access_tier                   = "Hot"
  account_replication_type      = "ZRS"
  resource_group_name           = azurerm_resource_group.notifications_rg.name
  location                      = azurerm_resource_group.notifications_rg.location
  advanced_threat_protection    = true
  public_network_access_enabled = true

  tags = var.tags
}

resource "azurerm_storage_table" "notificationhub_beta_test_users_table" {
  name                 = "notificationhub"
  storage_account_name = module.push_notif_beta_storage.name
}

resource "azurerm_key_vault_secret" "push_notifications_storage_connection_string" {
  name         = "${module.push_notifications_storage.name}-connection-string"
  value        = module.push_notifications_storage.primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}
