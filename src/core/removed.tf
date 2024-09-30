removed {
  from = azurerm_resource_group.rg_internal
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_resource_group.rg_external
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_resource_group.rg_common
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_resource_group.default_roleassignment_rg
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_resource_group.data
  lifecycle {
    destroy = false
  }
}
