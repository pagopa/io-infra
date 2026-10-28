removed {
  from = azurerm_management_lock.st_itn_01
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_management_lock.st_gwc_01
  lifecycle {
    destroy = false
  }
}

