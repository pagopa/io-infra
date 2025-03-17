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

# Private Endpoint
data "azurerm_subnet" "pep_snet" {
  name                 = "pendpoints"
  virtual_network_name = "${var.project}-vnet-common"
  resource_group_name  = "${var.project}-rg-common"
}

# Private DNS Zone
data "azurerm_private_dns_zone" "postgres" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = "${var.project}-rg-common"
}
