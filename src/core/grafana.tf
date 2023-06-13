resource "azurerm_resource_group" "grafana_dashboard_rg" {
  name     = "${local.project}-grafana-dashboard-rg"
  location = var.location

  tags = var.tags
}

resource "azurerm_dashboard_grafana" "grafana_dashboard" {
  name                              = "${local.project}-grafana"
  resource_group_name               = azurerm_resource_group.grafana_dashboard_rg.name
  location                          = var.location
  api_key_enabled                   = false
  deterministic_outbound_ip_enabled = true
  public_network_access_enabled     = true
  zone_redundancy_enabled           = true

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_role_assignment" "grafana_dashboard_monitoring_reader" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Monitoring Reader"
  principal_id         = azurerm_dashboard_grafana.grafana_dashboard.identity[0].principal_id
}

resource "azurerm_role_assignment" "grafana_dashboard_monitoring_contributor" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Monitoring Contributor"
  principal_id         = azurerm_dashboard_grafana.grafana_dashboard.identity[0].principal_id
}