import {
  to = module.networking_weu.module.vnet_common.azurerm_virtual_network.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common"
}
import {
  to = module.networking_weu.module.pep_snet.azurerm_subnet.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common/subnets/pendpoints"
}
import {
  to = module.global.module.dns.azurerm_dns_a_record.api_app_io_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.pagopa.it/A/api-app"
}
import {
  to = module.global.module.dns.azurerm_dns_a_record.api_internal_io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.italia.it/A/api-internal"
}
import {
  to = module.global.module.dns.azurerm_dns_a_record.api_io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.italia.it/A/api"
}
import {
  to = module.global.module.dns.azurerm_dns_a_record.api_io_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.pagopa.it/A/api"
}
import {
  to = module.global.module.dns.azurerm_dns_a_record.api_io_selfcare_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.selfcare.pagopa.it/A/api"
}
import {
  to = module.global.module.dns.azurerm_dns_a_record.api_mtls_io_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.pagopa.it/A/api-mtls"
}
import {
  to = module.global.module.dns.azurerm_dns_a_record.api_web_io_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.pagopa.it/A/api-web"
}
import {
  to = module.global.module.dns.azurerm_dns_a_record.continua_io_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.pagopa.it/A/continua"
}
import {
  to = module.global.module.dns.azurerm_dns_a_record.app_backend_io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.italia.it/A/app-backend"
}
import {
  to = module.global.module.dns.azurerm_dns_a_record.developerportal_backend_io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.italia.it/A/developerportal-backend"
}
import {
  to = module.global.module.dns.azurerm_dns_a_record.firmaconio_selfcare_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/firmaconio.selfcare.pagopa.it/A/@"
}
import {
  to = module.global.module.dns.azurerm_dns_a_record.oauth_io_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.pagopa.it/A/oauth"
}
import {
  to = module.global.module.dns.azurerm_dns_a_record.openid_provider_io_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.pagopa.it/A/openid-provider"
}
import {
  to = module.global.module.dns.azurerm_dns_a_record.selfcare_io_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.pagopa.it/A/selfcare"
}
import {
  to = module.global.module.dns.azurerm_dns_caa_record.firmaconio_selfcare_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/firmaconio.selfcare.pagopa.it/CAA/@"
}
import {
  to = module.global.module.dns.azurerm_dns_caa_record.io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.italia.it/CAA/@"
}
import {
  to = module.global.module.dns.azurerm_dns_caa_record.io_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.pagopa.it/CAA/@"
}
import {
  to = module.global.module.dns.azurerm_dns_caa_record.io_selfcare_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.selfcare.pagopa.it/CAA/@"
}
import {
  to = module.global.module.dns.azurerm_dns_caa_record.ioweb_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/ioapp.it/CAA/@"
}
import {
  to = module.global.module.dns.azurerm_dns_cname_record.sender
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.italia.it/CNAME/sender"
}
import {
  to = module.global.module.dns.azurerm_dns_ns_record.firma_io_pagopa_it_ns
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.pagopa.it/NS/firma"
}
import {
  to = module.global.module.dns.azurerm_dns_txt_record.io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.italia.it/TXT/@"
}
import {
  to = module.global.module.dns.azurerm_dns_txt_record.zendeskverification_io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.italia.it/TXT/zendeskverification"
}
import {
  to = module.global.module.dns.azurerm_dns_zone.firmaconio_selfcare_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/firmaconio.selfcare.pagopa.it"
}
import {
  to = module.global.module.dns.azurerm_dns_zone.io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.italia.it"
}
import {
  to = module.global.module.dns.azurerm_dns_zone.io_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.pagopa.it"
}
import {
  to = module.global.module.dns.azurerm_dns_zone.io_selfcare_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.selfcare.pagopa.it"
}
import {
  to = module.global.module.dns.azurerm_dns_zone.ioweb_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/ioapp.it"
}
import {
  to = module.global.module.dns.azurerm_private_dns_a_record.api_app_internal_io
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.Network/privateDnsZones/internal.io.pagopa.it/A/api-app"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone.azure_api_net
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/azure-api.net"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone.management_azure_api_net
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/management.azure-api.net"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone.scm_azure_api_net
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/scm.azure-api.net"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.azure_api_net_vnet_common["weu"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/azure-api.net/virtualNetworkLinks/io-p-vnet-common"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone.internal_io_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.Network/privateDnsZones/internal.io.pagopa.it"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone.privatelink_azurecr_io
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.azurecr.io"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone.privatelink_azurewebsites
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.azurewebsites.net"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone.privatelink_blob_core
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone.privatelink_documents
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.documents.azure.com"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone.privatelink_file_core
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.file.core.windows.net"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone.privatelink_mongo_cosmos
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.mongo.cosmos.azure.com"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone.privatelink_mysql_database_azure_com
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.mysql.database.azure.com"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone.privatelink_postgres_database_azure_com
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.postgres.database.azure.com"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone.privatelink_queue_core
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.queue.core.windows.net"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone.privatelink_redis_cache
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.redis.cache.windows.net"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone.privatelink_servicebus
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-evt-rg/providers/Microsoft.Network/privateDnsZones/privatelink.servicebus.windows.net"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone.privatelink_srch
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.search.windows.net"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone.privatelink_table_core
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.table.core.windows.net"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.azurewebsites_private_vnet["beta"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.azurewebsites.net/virtualNetworkLinks/io-p-weu-beta-vnet"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.azurewebsites_private_vnet["prod01"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.azurewebsites.net/virtualNetworkLinks/io-p-weu-prod01-vnet"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.azurewebsites_private_vnet["weu"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.azurewebsites.net/virtualNetworkLinks/io-p-vnet-common"
}
import {
  to = module.networking_weu.azurerm_nat_gateway.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/natGateways/io-p-natgw"
}
import {
  to = module.networking_weu.azurerm_nat_gateway_public_ip_association.this_pip_01[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/natGateways/io-p-natgw|/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/publicIPAddresses/io-p-natgw-pip-01"
}
import {
  to = module.networking_weu.azurerm_nat_gateway_public_ip_association.this_pip_01[1]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/natGateways/io-p-natgw|/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/publicIPAddresses/io-p-natgw-pip-02"
}
import {
  to = module.networking_weu.azurerm_public_ip.this_01[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/publicIPAddresses/io-p-natgw-pip-01"
}
import {
  to = module.networking_weu.azurerm_public_ip.this_01[1]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/publicIPAddresses/io-p-natgw-pip-02"
}
import {
  to = module.vnet_peering_weu.azurerm_virtual_network_peering.source["beta"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common/virtualNetworkPeerings/io-p-vnet-common-to-io-p-weu-beta-vnet"
}
import {
  to = module.vnet_peering_weu.azurerm_virtual_network_peering.target["beta"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-weu-beta-vnet-rg/providers/Microsoft.Network/virtualNetworks/io-p-weu-beta-vnet/virtualNetworkPeerings/io-p-weu-beta-vnet-to-io-p-vnet-common"
}
import {
  to = module.vnet_peering_weu.azurerm_virtual_network_peering.source["prod01"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common/virtualNetworkPeerings/io-p-vnet-common-to-io-p-weu-prod01-vnet"
}
import {
  to = module.vnet_peering_weu.azurerm_virtual_network_peering.target["prod01"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-weu-prod01-vnet-rg/providers/Microsoft.Network/virtualNetworks/io-p-weu-prod01-vnet/virtualNetworkPeerings/io-p-weu-prod01-vnet-to-io-p-vnet-common"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.blob_core_private_vnet["beta"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net/virtualNetworkLinks/io-p-weu-beta-vnet"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.blob_core_private_vnet["prod01"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net/virtualNetworkLinks/io-p-weu-prod01-vnet"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.blob_core_private_vnet["weu"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net/virtualNetworkLinks/io-p-vnet-common"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.documents_private_vnet["beta"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.documents.azure.com/virtualNetworkLinks/io-p-weu-beta-vnet"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.documents_private_vnet["prod01"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.documents.azure.com/virtualNetworkLinks/io-p-weu-prod01-vnet"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.documents_private_vnet["weu"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.documents.azure.com/virtualNetworkLinks/io-p-vnet-common"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.file_core_private_vnet["beta"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.file.core.windows.net/virtualNetworkLinks/io-p-weu-beta-vnet"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.file_core_private_vnet["prod01"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.file.core.windows.net/virtualNetworkLinks/io-p-weu-prod01-vnet"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.file_core_private_vnet["weu"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.file.core.windows.net/virtualNetworkLinks/io-p-vnet-common"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.internal_io_pagopa_it_private_vnet["beta"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.Network/privateDnsZones/internal.io.pagopa.it/virtualNetworkLinks/io-p-weu-beta-vnet"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.internal_io_pagopa_it_private_vnet["prod01"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.Network/privateDnsZones/internal.io.pagopa.it/virtualNetworkLinks/io-p-weu-prod01-vnet"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.internal_io_pagopa_it_private_vnet["weu"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.Network/privateDnsZones/internal.io.pagopa.it/virtualNetworkLinks/io-p-private-vnet-common"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.management_azure_api_net_vnet_common["weu"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/management.azure-api.net/virtualNetworkLinks/io-p-vnet-common"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.mongo_cosmos_private_vnet["beta"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.mongo.cosmos.azure.com/virtualNetworkLinks/io-p-weu-beta-vnet"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.mongo_cosmos_private_vnet["prod01"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.mongo.cosmos.azure.com/virtualNetworkLinks/io-p-weu-prod01-vnet"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.mongo_cosmos_private_vnet["weu"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.mongo.cosmos.azure.com/virtualNetworkLinks/io-p-vnet-common"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.privatelink_azurecr_io_vnet["beta"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.azurecr.io/virtualNetworkLinks/io-p-weu-beta-vnet"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.privatelink_azurecr_io_vnet["prod01"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.azurecr.io/virtualNetworkLinks/io-p-weu-prod01-vnet"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.privatelink_azurecr_io_vnet["weu"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.azurecr.io/virtualNetworkLinks/io-p-vnet-common"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.privatelink_mysql_database_azure_com_vnet["beta"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.mysql.database.azure.com/virtualNetworkLinks/io-p-weu-beta-vnet"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.privatelink_mysql_database_azure_com_vnet["prod01"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.mysql.database.azure.com/virtualNetworkLinks/io-p-weu-prod01-vnet"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.privatelink_mysql_database_azure_com_vnet["weu"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.mysql.database.azure.com/virtualNetworkLinks/io-p-vnet-common"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.privatelink_postgres_database_azure_com_vnet["beta"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.postgres.database.azure.com/virtualNetworkLinks/io-p-weu-beta-vnet"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.privatelink_postgres_database_azure_com_vnet["prod01"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.postgres.database.azure.com/virtualNetworkLinks/io-p-weu-prod01-vnet"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.privatelink_postgres_database_azure_com_vnet["weu"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.postgres.database.azure.com/virtualNetworkLinks/io-p-vnet-common"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.queue_core_private_vnet["beta"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.queue.core.windows.net/virtualNetworkLinks/io-p-weu-beta-vnet"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.queue_core_private_vnet["prod01"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.queue.core.windows.net/virtualNetworkLinks/io-p-weu-prod01-vnet"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.queue_core_private_vnet["weu"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.queue.core.windows.net/virtualNetworkLinks/io-p-vnet-common"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.redis_private_vnet["beta"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.redis.cache.windows.net/virtualNetworkLinks/io-p-weu-beta-vnet"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.redis_private_vnet["prod01"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.redis.cache.windows.net/virtualNetworkLinks/io-p-weu-prod01-vnet"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.redis_private_vnet["weu"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.redis.cache.windows.net/virtualNetworkLinks/io-p-redis-common-common"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.servicebus_private_vnet["prod01"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-evt-rg/providers/Microsoft.Network/privateDnsZones/privatelink.servicebus.windows.net/virtualNetworkLinks/io-p-weu-prod01-vnet"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.servicebus_private_vnet["beta"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-evt-rg/providers/Microsoft.Network/privateDnsZones/privatelink.servicebus.windows.net/virtualNetworkLinks/io-p-weu-beta-vnet"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.servicebus_private_vnet["weu"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-evt-rg/providers/Microsoft.Network/privateDnsZones/privatelink.servicebus.windows.net/virtualNetworkLinks/io-p-evh-ns-private-dns-zone-link-01"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.srch_private_vnet_common["weu"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.search.windows.net/virtualNetworkLinks/io-p-vnet-common"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.scm_azure_api_net_vnet_common["weu"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/scm.azure-api.net/virtualNetworkLinks/io-p-vnet-common"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.table_core_private_vnet["beta"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.table.core.windows.net/virtualNetworkLinks/io-p-weu-beta-vnet"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.table_core_private_vnet["prod01"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.table.core.windows.net/virtualNetworkLinks/io-p-weu-prod01-vnet"
}
import {
  to = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.table_core_private_vnet["weu"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.table.core.windows.net/virtualNetworkLinks/io-p-vnet-common"
}

moved {
  from = module.networking
  to   = module.networking_itn
}

moved {
  from = module.networking_itn.module.vnet_itn_common.azurerm_virtual_network.this
  to   = module.networking_itn.module.vnet_common.azurerm_virtual_network.this
}

moved {
  from = module.networking_itn.module.vnet_peering_itn_common_weu_beta.azurerm_virtual_network_peering.source
  to   = module.vnet_peering_itn.azurerm_virtual_network_peering.source["beta"]
}

moved {
  from = module.networking_itn.module.vnet_peering_itn_common_weu_beta.azurerm_virtual_network_peering.target
  to   = module.vnet_peering_itn.azurerm_virtual_network_peering.target["beta"]
}

moved {
  from = module.networking_itn.module.vnet_peering_itn_common_weu_prod01.azurerm_virtual_network_peering.source
  to   = module.vnet_peering_itn.azurerm_virtual_network_peering.source["prod01"]
}

moved {
  from = module.networking_itn.module.vnet_peering_itn_common_weu_prod01.azurerm_virtual_network_peering.target
  to   = module.vnet_peering_itn.azurerm_virtual_network_peering.target["prod01"]
}

moved {
  from = module.networking_itn.module.vnet_peering_weu_common_itn_common.azurerm_virtual_network_peering.target
  to   = module.vnet_peering_itn.azurerm_virtual_network_peering.source["weu"]
}

moved {
  from = module.networking_itn.module.vnet_peering_weu_common_itn_common.azurerm_virtual_network_peering.source
  to   = module.vnet_peering_weu.azurerm_virtual_network_peering.source["itn"]
}

moved {
  from = module.networking_itn.azurerm_private_dns_zone_virtual_network_link.azure_api_net_vnet_itn_common
  to   = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.azure_api_net_vnet_common["itn"]
}

moved {
  from = module.networking_itn.azurerm_private_dns_zone_virtual_network_link.blob_core_private_vnet_itn_common
  to   = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.blob_core_private_vnet["itn"]
}

moved {
  from = module.networking_itn.azurerm_private_dns_zone_virtual_network_link.documents_private_vnet_itn_common
  to   = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.documents_private_vnet["itn"]
}

moved {
  from = module.networking_itn.azurerm_private_dns_zone_virtual_network_link.file_core_private_vnet_itn_common
  to   = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.file_core_private_vnet["itn"]
}

moved {
  from = module.networking_itn.azurerm_private_dns_zone_virtual_network_link.internal_io_pagopa_it_private_vnet_itn_common
  to   = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.internal_io_pagopa_it_private_vnet["itn"]
}

moved {
  from = module.networking_itn.azurerm_private_dns_zone_virtual_network_link.management_azure_api_net_vnet_itn_common
  to   = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.management_azure_api_net_vnet_common["itn"]
}

moved {
  from = module.networking_itn.azurerm_private_dns_zone_virtual_network_link.mongo_cosmos_private_vnet_itn_common
  to   = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.mongo_cosmos_private_vnet["itn"]
}

moved {
  from = module.networking_itn.azurerm_private_dns_zone_virtual_network_link.privatelink_postgres_database_azure_com_vnet_itn_common
  to   = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.privatelink_postgres_database_azure_com_vnet["itn"]
}

moved {
  from = module.networking_itn.azurerm_private_dns_zone_virtual_network_link.queue_core_private_vnet_itn_common
  to   = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.queue_core_private_vnet["itn"]
}

moved {
  from = module.networking_itn.azurerm_private_dns_zone_virtual_network_link.redis_private_vnet_itn_common
  to   = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.redis_private_vnet["itn"]
}

moved {
  from = module.networking_itn.azurerm_private_dns_zone_virtual_network_link.scm_azure_api_net_vnet_itn_common
  to   = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.scm_azure_api_net_vnet_common["itn"]
}

moved {
  from = module.networking_itn.azurerm_private_dns_zone_virtual_network_link.servicebus_private_vnet_itn_common
  to   = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.servicebus_private_vnet["itn"]
}

moved {
  from = module.networking_itn.azurerm_private_dns_zone_virtual_network_link.srch_private_vnet_itn_common
  to   = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.srch_private_vnet_common["itn"]
}

moved {
  from = module.networking_itn.azurerm_private_dns_zone_virtual_network_link.table_core_private_vnet_itn_common
  to   = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.table_core_private_vnet["itn"]
}

moved {
  from = module.networking_itn.azurerm_private_dns_zone_virtual_network_link.azurewebsites_private_vnet_itn_common
  to   = module.global.module.dns.azurerm_private_dns_zone_virtual_network_link.azurewebsites_private_vnet["itn"]
}
