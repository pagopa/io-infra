# Use this file to import the wanted resources inside the state file, 
# remember to cleanup the import code blocks with a separate PR once the import has been completed successfully.
# Here is the documentation which explains how to use the import code block: https://developer.hashicorp.com/terraform/language/block/import

import {
  to = module.dns.module.dns.azurerm_dns_a_record.api_app_io_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.pagopa.it/A/api-app"
}

import {
  to = module.dns.module.dns.azurerm_dns_a_record.api_internal_io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.italia.it/A/api-internal"
}

import {
  to = module.dns.module.dns.azurerm_dns_a_record.api_io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.italia.it/A/api"
}

import {
  to = module.dns.module.dns.azurerm_dns_a_record.api_io_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.pagopa.it/A/api"
}

import {
  to = module.dns.module.dns.azurerm_dns_a_record.api_mtls_io_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.pagopa.it/A/api-mtls"
}

import {
  to = module.dns.module.dns.azurerm_dns_a_record.api_web_io_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.pagopa.it/A/api-web"
}

import {
  to = module.dns.module.dns.azurerm_dns_a_record.app_backend_io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.italia.it/A/app-backend"
}

import {
  to = module.dns.module.dns.azurerm_dns_a_record.continua_io_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.pagopa.it/A/continua"
}

import {
  to = module.dns.module.dns.azurerm_dns_a_record.developerportal_backend_io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.italia.it/A/developerportal-backend"
}

import {
  to = module.dns.module.dns.azurerm_dns_a_record.firmaconio_selfcare_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/firmaconio.selfcare.pagopa.it/A/@"
}

import {
  to = module.dns.module.dns.azurerm_dns_a_record.licences_ipatente_io_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/ipatente.io.pagopa.it/A/licences"
}

import {
  to = module.dns.module.dns.azurerm_dns_a_record.oauth_io_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.pagopa.it/A/oauth"
}

import {
  to = module.dns.module.dns.azurerm_dns_a_record.openid_provider_io_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.pagopa.it/A/openid-provider"
}

import {
  to = module.dns.module.dns.azurerm_dns_a_record.payments_ipatente_io_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/ipatente.io.pagopa.it/A/payments"
}

import {
  to = module.dns.module.dns.azurerm_dns_a_record.practices_ipatente_io_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/ipatente.io.pagopa.it/A/practices"
}

import {
  to = module.dns.module.dns.azurerm_dns_a_record.selfcare_io_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.pagopa.it/A/selfcare"
}

import {
  to = module.dns.module.dns.azurerm_dns_a_record.vehicles_ipatente_io_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/ipatente.io.pagopa.it/A/vehicles"
}

import {
  to = module.dns.module.dns.azurerm_dns_caa_record.firmaconio_selfcare_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/firmaconio.selfcare.pagopa.it/CAA/@"
}

import {
  to = module.dns.module.dns.azurerm_dns_caa_record.io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.italia.it/CAA/@"
}

import {
  to = module.dns.module.dns.azurerm_dns_caa_record.io_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.pagopa.it/CAA/@"
}

import {
  to = module.dns.module.dns.azurerm_dns_caa_record.ioweb_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/ioapp.it/CAA/@"
}

import {
  to = module.dns.module.dns.azurerm_dns_caa_record.ipatente_io_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/ipatente.io.pagopa.it/CAA/@"
}

import {
  to = module.dns.module.dns.azurerm_dns_cname_record.aws_cert_validation_ioweb
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/ioapp.it/CNAME/_1b96136662809f31f497b4fcd6b32a8d"
}

import {
  to = module.dns.module.dns.azurerm_dns_cname_record.continua
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/ioapp.it/CNAME/continua"
}

import {
  to = module.dns.module.dns.azurerm_dns_cname_record.firmaconio
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.italia.it/CNAME/_c8fedcbb95e9a1a9970e790248192e40.firma"
}

import {
  to = module.dns.module.dns.azurerm_dns_cname_record.sender
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.italia.it/CNAME/sender"
}

import {
  to = module.dns.module.dns.azurerm_dns_cname_record.zendesk
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/ioapp.it/CNAME/assistenza"
}

import {
  to = module.dns.module.dns.azurerm_dns_ns_record.firma_io_pagopa_it_ns
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.pagopa.it/NS/firma"
}

import {
  to = module.dns.module.dns.azurerm_dns_ns_record.ipatente_io_pagopa_it_ns
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.pagopa.it/NS/ipatente"
}

import {
  to = module.dns.module.dns.azurerm_dns_txt_record.cie_app_io_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.pagopa.it/TXT/cie.app"
}

import {
  to = module.dns.module.dns.azurerm_dns_txt_record.dmarc_ioweb_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/ioapp.it/TXT/_dmarc"
}

import {
  to = module.dns.module.dns.azurerm_dns_txt_record.io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.italia.it/TXT/@"
}

import {
  to = module.dns.module.dns.azurerm_dns_txt_record.spf_ioweb_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/ioapp.it/TXT/@"
}

import {
  to = module.dns.module.dns.azurerm_dns_txt_record.zendeskverification_io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.italia.it/TXT/zendeskverification"
}

import {
  to = module.dns.module.dns.azurerm_dns_zone.firmaconio_selfcare_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/firmaconio.selfcare.pagopa.it"
}

import {
  to = module.dns.module.dns.azurerm_dns_zone.io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.italia.it"
}

import {
  to = module.dns.module.dns.azurerm_dns_zone.io_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.pagopa.it"
}

import {
  to = module.dns.module.dns.azurerm_dns_zone.ioweb_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/ioapp.it"
}

import {
  to = module.dns.module.dns.azurerm_dns_zone.ipatente_io_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/ipatente.io.pagopa.it"
}

import {
  to = module.dns.module.dns.azurerm_dns_zone.wallet_io_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/wallet.io.pagopa.it"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_a_record.api_app_internal_io
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.Network/privateDnsZones/internal.io.pagopa.it/A/api-app"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_a_record.proxy_internal_io
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.Network/privateDnsZones/internal.io.pagopa.it/A/proxy"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone.azure_api_net
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/azure-api.net"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone.internal_io_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.Network/privateDnsZones/internal.io.pagopa.it"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone.management_azure_api_net
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/management.azure-api.net"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone.privatelink_azurecr_io
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.azurecr.io"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone.privatelink_azurewebsites
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.azurewebsites.net"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone.privatelink_blob_core
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone.privatelink_documents
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.documents.azure.com"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone.privatelink_file_core
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.file.core.windows.net"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone.privatelink_itn_containerapps
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.italynorth.azurecontainerapps.io"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone.privatelink_mongo_cosmos
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.mongo.cosmos.azure.com"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone.privatelink_mysql_database_azure_com
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.mysql.database.azure.com"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone.privatelink_postgres_database_azure_com
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.postgres.database.azure.com"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone.privatelink_queue_core
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.queue.core.windows.net"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone.privatelink_redis_cache
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.redis.cache.windows.net"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone.privatelink_servicebus
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-evt-rg/providers/Microsoft.Network/privateDnsZones/privatelink.servicebus.windows.net"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone.privatelink_srch
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.search.windows.net"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone.privatelink_table_core
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.table.core.windows.net"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone.privatelink_vault
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone.scm_azure_api_net
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/scm.azure-api.net"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.azure_api_net_vnet_common["itn"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/azure-api.net/virtualNetworkLinks/io-p-itn-common-vnet-01"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.azure_api_net_vnet_common["weu"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/azure-api.net/virtualNetworkLinks/io-p-vnet-common"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.azurewebsites_private_vnet["itn"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.azurewebsites.net/virtualNetworkLinks/io-p-itn-common-vnet-01"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.azurewebsites_private_vnet["weu"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.azurewebsites.net/virtualNetworkLinks/io-p-vnet-common"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.blob_core_private_vnet["itn"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net/virtualNetworkLinks/io-p-itn-common-vnet-01"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.blob_core_private_vnet["weu"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net/virtualNetworkLinks/io-p-vnet-common"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.documents_private_vnet["itn"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.documents.azure.com/virtualNetworkLinks/io-p-itn-common-vnet-01"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.documents_private_vnet["weu"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.documents.azure.com/virtualNetworkLinks/io-p-vnet-common"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.file_core_private_vnet["itn"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.file.core.windows.net/virtualNetworkLinks/io-p-itn-common-vnet-01"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.file_core_private_vnet["weu"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.file.core.windows.net/virtualNetworkLinks/io-p-vnet-common"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.internal_io_pagopa_it_private_vnet["itn"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.Network/privateDnsZones/internal.io.pagopa.it/virtualNetworkLinks/io-p-itn-common-vnet-01"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.internal_io_pagopa_it_private_vnet["weu"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.Network/privateDnsZones/internal.io.pagopa.it/virtualNetworkLinks/io-p-private-vnet-common"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.management_azure_api_net_vnet_common["itn"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/management.azure-api.net/virtualNetworkLinks/io-p-itn-common-vnet-01"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.management_azure_api_net_vnet_common["weu"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/management.azure-api.net/virtualNetworkLinks/io-p-vnet-common"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.mongo_cosmos_private_vnet["itn"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.mongo.cosmos.azure.com/virtualNetworkLinks/io-p-itn-common-vnet-01"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.mongo_cosmos_private_vnet["weu"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.mongo.cosmos.azure.com/virtualNetworkLinks/io-p-vnet-common"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.privatelink_azurecr_io_vnet["itn"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.azurecr.io/virtualNetworkLinks/io-p-itn-common-vnet-01"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.privatelink_azurecr_io_vnet["weu"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.azurecr.io/virtualNetworkLinks/io-p-vnet-common"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.privatelink_itn_containerapps_vnet_common["itn"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.italynorth.azurecontainerapps.io/virtualNetworkLinks/io-p-itn-common-vnet-01"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.privatelink_itn_containerapps_vnet_common["weu"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.italynorth.azurecontainerapps.io/virtualNetworkLinks/io-p-vnet-common"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.privatelink_mysql_database_azure_com_vnet["itn"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.mysql.database.azure.com/virtualNetworkLinks/io-p-itn-common-vnet-01"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.privatelink_mysql_database_azure_com_vnet["weu"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.mysql.database.azure.com/virtualNetworkLinks/io-p-vnet-common"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.privatelink_postgres_database_azure_com_vnet["itn"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.postgres.database.azure.com/virtualNetworkLinks/io-p-itn-common-vnet-01"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.privatelink_postgres_database_azure_com_vnet["weu"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.postgres.database.azure.com/virtualNetworkLinks/io-p-vnet-common"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.queue_core_private_vnet["itn"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.queue.core.windows.net/virtualNetworkLinks/io-p-itn-common-vnet-01"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.queue_core_private_vnet["weu"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.queue.core.windows.net/virtualNetworkLinks/io-p-vnet-common"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.redis_private_vnet["itn"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.redis.cache.windows.net/virtualNetworkLinks/io-p-itn-common-vnet-01"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.redis_private_vnet["weu"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.redis.cache.windows.net/virtualNetworkLinks/io-p-redis-common-common"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.scm_azure_api_net_vnet_common["itn"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/scm.azure-api.net/virtualNetworkLinks/io-p-itn-common-vnet-01"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.scm_azure_api_net_vnet_common["weu"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/scm.azure-api.net/virtualNetworkLinks/io-p-vnet-common"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.servicebus_private_vnet["itn"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-evt-rg/providers/Microsoft.Network/privateDnsZones/privatelink.servicebus.windows.net/virtualNetworkLinks/io-p-itn-common-vnet-01"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.servicebus_private_vnet["weu"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-evt-rg/providers/Microsoft.Network/privateDnsZones/privatelink.servicebus.windows.net/virtualNetworkLinks/io-p-evh-ns-private-dns-zone-link-01"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.srch_private_vnet_common["itn"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.search.windows.net/virtualNetworkLinks/io-p-itn-common-vnet-01"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.srch_private_vnet_common["weu"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.search.windows.net/virtualNetworkLinks/io-p-vnet-common"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.table_core_private_vnet["itn"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.table.core.windows.net/virtualNetworkLinks/io-p-itn-common-vnet-01"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.table_core_private_vnet["weu"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.table.core.windows.net/virtualNetworkLinks/io-p-vnet-common"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.vault_private_vnet_common["itn"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net/virtualNetworkLinks/io-p-itn-common-vnet-01"
}

import {
  to = module.dns.module.dns.azurerm_private_dns_zone_virtual_network_link.vault_private_vnet_common["weu"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net/virtualNetworkLinks/io-p-vnet-common"
}

