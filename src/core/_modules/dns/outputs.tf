output "public_dns_zones" {
    value = {
        io = {
            name = length(azurerm_dns_zone.io_pagopa_it) > 0 ? azurerm_dns_zone.io_pagopa_it[0].name : null
        }

        firmaconio_selfcare_pagopa_it = {
            name = length(azurerm_dns_zone.firmaconio_selfcare_pagopa_it) > 0 ? azurerm_dns_zone.io_pagopa_it[0].name : null
        }
        
        io_italia_it = {
            name = azurerm_dns_zone.io_italia_it.name
        }

        io_selfcare_pagopa_it = {
            name = length(azurerm_dns_zone.io_selfcare_pagopa_it) > 0 ? azurerm_dns_zone.io_pagopa_it[0].name : null
        }

        ioweb_it = {
            name = azurerm_dns_zone.ioweb_it.name
        }
    }
}