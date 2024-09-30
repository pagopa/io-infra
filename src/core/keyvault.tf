data "azurerm_key_vault" "key_vault" {
  name                = format("%s-kv", local.project)
  resource_group_name = data.azurerm_resource_group.sec_rg.name
}

data "azurerm_key_vault" "key_vault_common" {
  name                = format("%s-kv-common", local.project)
  resource_group_name = data.azurerm_resource_group.rg_common.name
}

data "azurerm_resource_group" "sec_rg" {
  name = format("%s-sec-rg", local.project)
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "appinsights_instrumentation_key" {
  name         = "appinsights-instrumentation-key"
  value        = data.azurerm_application_insights.application_insights.instrumentation_key
  content_type = "only instrumentation key"

  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "appinsights_connection_string" {
  name         = "appinsights-connection-string"
  value        = data.azurerm_application_insights.application_insights.connection_string
  content_type = "full connection string, example InstrumentationKey=XXXXX"

  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}
