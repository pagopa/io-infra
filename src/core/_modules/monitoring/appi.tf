resource "azurerm_application_insights" "appi" {
  name                = local.nonstandard[var.location_short].appi
  location            = var.location
  resource_group_name = var.resource_group_common
  disable_ip_masking  = true
  application_type    = "other"

  workspace_id = azurerm_log_analytics_workspace.log.id

  tags = var.tags
}
