removed {
  from = module.networking_weu.module.vnet_common.azurerm_virtual_network.this
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.networking_weu.module.pep_snet.azurerm_subnet.this
  lifecycle {
    destroy = false
  }
}
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
  from = module.global.module.dns.azurerm_dns_a_record.api_io_selfcare_pagopa_it
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
  from = module.global.module.dns.azurerm_dns_a_record.continua_io_pagopa_it
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
  from = module.global.module.dns.azurerm_dns_a_record.selfcare_io_pagopa_it
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
  from = module.global.module.dns.azurerm_dns_caa_record.io_selfcare_pagopa_it
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
  from = module.global.module.dns.azurerm_dns_cname_record.sender
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
  from = module.global.module.dns.azurerm_dns_txt_record.io_italia_it
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
  from = module.global.module.dns.azurerm_dns_zone.io_selfcare_pagopa_it
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
  from = module.global.module.dns.azurerm_private_dns_a_record.api_app_internal_io
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
  from = module.global.module.dns.azurerm_private_dns_zone.management_azure_api_net
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
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.azure_api_net_vnet_common["weu"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.azure_api_net_vnet_common["itn"]
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
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.azurewebsites_private_vnet["beta"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.azurewebsites_private_vnet["prod01"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.azurewebsites_private_vnet["weu"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.azurewebsites_private_vnet["itn"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.networking_weu.azurerm_nat_gateway.this
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.networking_weu.azurerm_nat_gateway_public_ip_association.this_pip_01[0]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.networking_weu.azurerm_nat_gateway_public_ip_association.this_pip_01[1]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.networking_weu.azurerm_public_ip.this_01[0]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.networking_weu.azurerm_public_ip.this_01[1]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.vnet_peering_weu.azurerm_virtual_network_peering.source["beta"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.vnet_peering_weu.azurerm_virtual_network_peering.target["beta"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.vnet_peering_weu.azurerm_virtual_network_peering.source["prod01"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.vnet_peering_weu.azurerm_virtual_network_peering.target["prod01"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.blob_core_private_vnet["beta"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.blob_core_private_vnet["itn"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.blob_core_private_vnet["prod01"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.blob_core_private_vnet["weu"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.documents_private_vnet["beta"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.documents_private_vnet["itn"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.documents_private_vnet["prod01"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.documents_private_vnet["weu"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.file_core_private_vnet["beta"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.file_core_private_vnet["prod01"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.file_core_private_vnet["weu"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.file_core_private_vnet["itn"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.internal_io_pagopa_it_private_vnet["beta"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.internal_io_pagopa_it_private_vnet["itn"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.internal_io_pagopa_it_private_vnet["prod01"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.internal_io_pagopa_it_private_vnet["weu"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.management_azure_api_net_vnet_common["weu"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.management_azure_api_net_vnet_common["itn"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.mongo_cosmos_private_vnet["beta"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.mongo_cosmos_private_vnet["prod01"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.mongo_cosmos_private_vnet["weu"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.mongo_cosmos_private_vnet["itn"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.privatelink_azurecr_io_vnet["beta"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.privatelink_azurecr_io_vnet["prod01"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.privatelink_azurecr_io_vnet["weu"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.privatelink_azurecr_io_vnet["itn"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.privatelink_mysql_database_azure_com_vnet["beta"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.privatelink_mysql_database_azure_com_vnet["prod01"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.privatelink_mysql_database_azure_com_vnet["weu"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.privatelink_mysql_database_azure_com_vnet["itn"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.privatelink_postgres_database_azure_com_vnet["beta"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.privatelink_postgres_database_azure_com_vnet["prod01"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.privatelink_postgres_database_azure_com_vnet["weu"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.privatelink_postgres_database_azure_com_vnet["itn"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.queue_core_private_vnet["beta"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.queue_core_private_vnet["prod01"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.queue_core_private_vnet["weu"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.queue_core_private_vnet["itn"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.redis_private_vnet["beta"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.redis_private_vnet["prod01"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.redis_private_vnet["weu"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.redis_private_vnet["itn"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.servicebus_private_vnet["prod01"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.servicebus_private_vnet["beta"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.servicebus_private_vnet["weu"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.servicebus_private_vnet["itn"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.srch_private_vnet_common["weu"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.srch_private_vnet_common["itn"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.scm_azure_api_net_vnet_common["weu"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.scm_azure_api_net_vnet_common["itn"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.table_core_private_vnet["beta"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.table_core_private_vnet["prod01"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.table_core_private_vnet["weu"]
  lifecycle {
    destroy = false
  }
}
removed {
  from = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.table_core_private_vnet["itn"]
  lifecycle {
    destroy = false
  }
}
