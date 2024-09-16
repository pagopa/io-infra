removed {
  from = module.azdoa_snet

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.azdoa_loadtest_li

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.azdoa_li_infra

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_resource_group.azdo_rg

  lifecycle {
    destroy = false
  }
}