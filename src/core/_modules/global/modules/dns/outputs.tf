output "public_dns_zones" {
  value = {
    io = {
      name = azurerm_dns_zone.io_pagopa_it.name
    }

    firmaconio_selfcare_pagopa_it = {
      name = azurerm_dns_zone.io_pagopa_it.name
    }

    io_italia_it = {
      name = azurerm_dns_zone.io_italia_it.name
    }

    io_selfcare_pagopa_it = {
      name = azurerm_dns_zone.io_pagopa_it.name
    }

    ioweb_it = {
      name = azurerm_dns_zone.ioweb_it.name
    }
  }
}

output "private_dns_zones" {
  value = {
    privatelink_servicebus = azurerm_private_dns_zone.privatelink_servicebus
  }
}