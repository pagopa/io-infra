removed {
  from = azurerm_key_vault_secret.appinsights_connection_string
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_secret.appinsights_instrumentation_key
  lifecycle {
    destroy = false
  }
}
