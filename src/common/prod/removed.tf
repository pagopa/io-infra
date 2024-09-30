removed {
  from = module.assets_cdn_weu.azurerm_resource_group.assets_cdn_rg
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_resource_group.rg_linux
  lifecycle {
    destroy = false
  }
}
