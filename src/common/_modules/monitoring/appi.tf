resource "azurerm_application_insights" "appi" {
  name                = try(local.nonstandard[var.location_short].appi, "${var.project}-appi-01")
  location            = var.location
  resource_group_name = var.resource_group_common
  disable_ip_masking  = true
  application_type    = "other"

  workspace_id = azurerm_log_analytics_workspace.log.id

  tags = var.tags
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "appinsights_instrumentation_key" {
  name         = "appinsights-instrumentation-key"
  value        = azurerm_application_insights.appi.instrumentation_key
  content_type = "only instrumentation key"

  key_vault_id = var.kv_common_id
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "appinsights_connection_string" {
  name         = "appinsights-connection-string"
  value        = azurerm_application_insights.appi.connection_string
  content_type = "full connection string, example InstrumentationKey=XXXXX"

  key_vault_id = var.kv_common_id
}
