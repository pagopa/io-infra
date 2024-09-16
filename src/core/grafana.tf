removed {
  from = azurerm_resource_group.grafana_dashboard_rg

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_dashboard_grafana.grafana_dashboard

  lifecycle {
    destroy = false
  }
}
