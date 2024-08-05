removed {
  from = module.event_hub

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.eventhub_snet

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_resource_group.event_rg

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_secret.event_hub_keys

  lifecycle {
    destroy = false
  }
}