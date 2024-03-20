data "azurerm_monitor_action_group" "error_action_group" {
  name                = "${replace("${var.project}", "-", "")}error"
  resource_group_name = local.resource_group_name_common
}

data "azurerm_private_dns_zone" "privatelink_postgres_database_azure_com" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = local.resource_group_name_common
}

data "azurerm_key_vault" "key_vault_common" {
  name                = "${var.project}-kv-common"
  resource_group_name = local.resource_group_name_common
}

data "azurerm_key_vault_secret" "subscriptionmigrations_db_server_adm_password" {
  name         = "selfcare-subsmigrations-DB-ADM-PASSWORD"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "subscriptionmigrations_db_server_adm_username" {
  name         = "selfcare-subsmigrations-DB-ADM-USERNAME"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "devportalservicedata_db_server_adm_password" {
  name         = "devportal-servicedata-DB-ADM-PASSWORD"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "devportalservicedata_db_server_adm_username" {
  name         = "devportal-servicedata-DB-ADM-USERNAME"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}
