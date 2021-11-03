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
# App Backend resources
#

data "azurerm_app_service" "appbackendl1" {
  name                = format("%s-app-appbackendl1", local.project)
  resource_group_name = format("%s-rg-linux", local.project)
}

data "azurerm_app_service" "appbackendl2" {
  name                = format("%s-app-appbackendl2", local.project)
  resource_group_name = format("%s-rg-linux", local.project)
}

data "azurerm_app_service" "appbackendli" {
  name                = format("%s-app-appbackendli", local.project)
  resource_group_name = format("%s-rg-linux", local.project)
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
