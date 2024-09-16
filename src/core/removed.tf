removed {
  from = module.assets_cdn

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_resource_group.assets_cdn_rg

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_dns_cname_record.assets_cdn_io_pagopa_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_dns_cname_record.assets_cdn_io_italia_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_cdn_profile.assets_cdn_profile

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_cdn_endpoint_custom_domain.assets_cdn_io_italia_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_cdn_endpoint_custom_domain.assets_cdn

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_cdn_endpoint.assets_cdn_endpoint

  lifecycle {
    destroy = false
  }
}