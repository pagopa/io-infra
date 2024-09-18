
##############################
# Locked User Profiles Storage
##############################
removed {
  from = module.locked_profiles_storage

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_private_endpoint.locked_profiles_storage_table

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_storage_table.locked_profiles

  lifecycle {
    destroy = false
  }
}