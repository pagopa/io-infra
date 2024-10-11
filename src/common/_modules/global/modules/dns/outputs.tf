output "public_dns_zones" {
  value = {
    io = {
      name     = azurerm_dns_zone.io_pagopa_it.name
      api      = trimsuffix(azurerm_dns_a_record.api_io_pagopa_it.fqdn, ".")
      api_app  = trimsuffix(azurerm_dns_a_record.api_app_io_pagopa_it.fqdn, ".")
      api_web  = trimsuffix(azurerm_dns_a_record.api_web_io_pagopa_it.fqdn, ".")
      api_mtls = trimsuffix(azurerm_dns_a_record.api_mtls_io_pagopa_it.fqdn, ".")
      continua = trimsuffix(azurerm_dns_a_record.continua_io_pagopa_it.fqdn, ".")
    }

    firmaconio_selfcare_pagopa_it = {
      name = azurerm_dns_zone.firmaconio_selfcare_pagopa_it.name
    }

    io_italia_it = {
      name                     = azurerm_dns_zone.io_italia_it.name
      developer_portal_backend = trimsuffix(azurerm_dns_a_record.developerportal_backend_io_italia_it.fqdn, ".")
      api                      = trimsuffix(azurerm_dns_a_record.api_io_italia_it.fqdn, ".")
      app_backend              = trimsuffix(azurerm_dns_a_record.app_backend_io_italia_it.fqdn, ".")
    }

    io_selfcare_pagopa_it = {
      name = azurerm_dns_zone.io_selfcare_pagopa_it.name
      api  = trimsuffix(azurerm_dns_a_record.api_io_selfcare_pagopa_it.fqdn, ".")
    }

    ioweb_it = {
      name = azurerm_dns_zone.ioweb_it.name
    }
  }
}

output "private_dns_zones" {
  value = {
    servicebus = azurerm_private_dns_zone.privatelink_servicebus
    documents  = azurerm_private_dns_zone.privatelink_documents
    postgres   = azurerm_private_dns_zone.privatelink_postgres_database_azure_com
  }
}

output "external_domain" {
  value = var.external_domain
}

output "dns_default_ttl_sec" {
  value = var.dns_default_ttl_sec
}