resource "azurerm_resource_group" "grafana_dashboard_rg" {
  name     = "${local.project}-grafana-dashboard-rg"
  location = var.location

  tags = var.tags
}

data "azurerm_key_vault_secret" "smtp" {
  name         = "${local.project}-grafana-smtp-password"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

resource "azurerm_dashboard_grafana" "grafana_dashboard" {
  name                              = "${local.project}-grafana"
  resource_group_name               = azurerm_resource_group.grafana_dashboard_rg.name
  location                          = var.location
  api_key_enabled                   = true
  deterministic_outbound_ip_enabled = true
  public_network_access_enabled     = true
  zone_redundancy_enabled           = true
  grafana_major_version             = 10

  identity {
    type = "SystemAssigned"
  }

  smtp {
    enabled                   = true
    from_address              = "io-service-management@pagopa.it"
    from_name                 = "Service Management di IO"
    host                      = "smtp.gmail.com:587"
    start_tls_policy          = "OpportunisticStartTLS"
    user                      = "io-service-management@pagopa.it"
    verification_skip_enabled = false
    password                  = data.azurerm_key_vault_secret.smtp.value
  }

  tags = var.tags
}

# TODO: review pipeline permissions
# resource "azurerm_role_assignment" "grafana_dashboard_monitoring_reader" {
#   scope                = data.azurerm_subscription.current.id
#   role_definition_name = "Monitoring Reader"
#   principal_id         = azurerm_dashboard_grafana.grafana_dashboard.identity[0].principal_id
# }

# resource "azurerm_role_assignment" "grafana_dashboard_monitoring_contributor" {
#   scope                = data.azurerm_subscription.current.id
#   role_definition_name = "Monitoring Contributor"
#   principal_id         = azurerm_dashboard_grafana.grafana_dashboard.identity[0].principal_id
# }
