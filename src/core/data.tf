resource "azurerm_resource_group" "data" {
  name     = format("%s-data-rg", local.project)
  location = var.location

  tags = var.tags
}

data "azurerm_cosmosdb_account" "cosmos_api" {
  name                = format("%s-cosmos-api", local.project)
  resource_group_name = format("%s-rg-internal", local.project)
}



#
# EUCovicCert resources
#

data "azurerm_function_app" "fnapp_eucovidcert" {
  name                = format("%s-fn3-eucovidcert", local.project)
  resource_group_name = format("%s-rg-eucovidcert", local.project)
}

data "azurerm_key_vault_secret" "fnapp_eucovidcert_authtoken" {
  name         = "funceucovidcert-KEY-PUBLICIOEVENTDISPATCHER"
  key_vault_id = module.key_vault.id
}
