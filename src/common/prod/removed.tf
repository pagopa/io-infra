# This file will contain all the removed without destroy code blocks generated and used during the common domain split into multiple subdomains / platform
# https://pagopa.atlassian.net/browse/IOPLT-1626

removed {
  from = module.global.module.dns.azurerm_dns_a_record.api_app_io_pagopa_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_a_record.api_internal_io_italia_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_a_record.api_io_italia_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_a_record.api_io_pagopa_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_a_record.api_mtls_io_pagopa_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_a_record.api_web_io_pagopa_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_a_record.app_backend_io_italia_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_a_record.continua_io_pagopa_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_a_record.developerportal_backend_io_italia_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_a_record.firmaconio_selfcare_pagopa_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_a_record.licences_ipatente_io_pagopa_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_a_record.oauth_io_pagopa_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_a_record.openid_provider_io_pagopa_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_a_record.payments_ipatente_io_pagopa_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_a_record.practices_ipatente_io_pagopa_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_a_record.selfcare_io_pagopa_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_a_record.vehicles_ipatente_io_pagopa_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_caa_record.firmaconio_selfcare_pagopa_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_caa_record.io_italia_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_caa_record.io_pagopa_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_caa_record.ioweb_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_caa_record.ipatente_io_pagopa_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_cname_record.aws_cert_validation_ioweb

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_cname_record.continua

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_cname_record.firmaconio

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_cname_record.sender

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_cname_record.zendesk

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_ns_record.firma_io_pagopa_it_ns

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_ns_record.ipatente_io_pagopa_it_ns

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_txt_record.cie_app_io_pagopa_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_txt_record.dmarc_ioweb_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_txt_record.io_italia_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_txt_record.spf_ioweb_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_txt_record.zendeskverification_io_italia_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_zone.firmaconio_selfcare_pagopa_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_zone.io_italia_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_zone.io_pagopa_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_zone.ioweb_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_zone.ipatente_io_pagopa_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_dns_zone.wallet_io_pagopa_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_a_record.api_app_internal_io

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_a_record.proxy_internal_io

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.azure_api_net_vnet_common

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.azurewebsites_private_vnet

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.blob_core_private_vnet

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.documents_private_vnet

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.file_core_private_vnet

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.internal_io_pagopa_it_private_vnet

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.management_azure_api_net_vnet_common

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.mongo_cosmos_private_vnet

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.privatelink_azurecr_io_vnet

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.privatelink_itn_containerapps_vnet_common

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.privatelink_mysql_database_azure_com_vnet

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.privatelink_postgres_database_azure_com_vnet

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.queue_core_private_vnet

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.redis_private_vnet

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.scm_azure_api_net_vnet_common

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.servicebus_private_vnet

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.srch_private_vnet_common

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.table_core_private_vnet

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.vault_private_vnet_common

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone.azure_api_net

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone.internal_io_pagopa_it

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone.management_azure_api_net

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone.privatelink_azurecr_io

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone.privatelink_azurewebsites

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone.privatelink_blob_core

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone.privatelink_documents

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone.privatelink_file_core

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone.privatelink_itn_containerapps

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone.privatelink_mongo_cosmos

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone.privatelink_mysql_database_azure_com

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone.privatelink_postgres_database_azure_com

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone.privatelink_queue_core

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone.privatelink_redis_cache

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone.privatelink_servicebus

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone.privatelink_srch

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone.privatelink_table_core

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone.privatelink_vault

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.global.module.dns.azurerm_private_dns_zone.scm_azure_api_net

  lifecycle {
    destroy = false
  }
}