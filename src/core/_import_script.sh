#!/bin/bash

bash terraform.sh init prod

### Step 1

# bash terraform.sh import prod 'azurerm_resource_group.rg_common' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common'

# bash terraform.sh import prod 'module.key_vault_common.azurerm_key_vault.this' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.KeyVault/vaults/io-p-kv-common'

# terraform state rm 'module.key_vault.azurerm_management_lock.this[0]'

# bash terraform.sh import prod 'azurerm_log_analytics_workspace.log_analytics_workspace' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.OperationalInsights/workspaces/io-p-law-common'

# bash terraform.sh import prod 'azurerm_application_insights.application_insights' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/microsoft.insights/components/io-p-ai-common'

# bash terraform.sh import prod 'azurerm_private_dns_zone.privatelink_servicebus' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-evt-rg/providers/Microsoft.Network/privateDnsZones/privatelink.servicebus.windows.net'

# bash terraform.sh import prod 'azurerm_private_dns_zone.privatelink_documents' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.documents.azure.com'

# bash terraform.sh import prod 'azurerm_private_dns_zone.privatelink_blob_core' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net'

# bash terraform.sh import prod 'azurerm_private_dns_zone.privatelink_file_core' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.file.core.windows.net'

# bash terraform.sh import prod 'azurerm_private_dns_zone.privatelink_table_core' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.table.core.windows.net'

# bash terraform.sh import prod 'azurerm_private_dns_zone.privatelink_queue_core' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/privatelink.queue.core.windows.net'

# bash terraform.sh import prod 'module.vnet_common.azurerm_virtual_network.this' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common'

# bash terraform.sh import prod 'module.redis_common_snet.azurerm_subnet.this' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common/subnets/rediscommon'

# bash terraform.sh import prod 'module.redis_common.azurerm_redis_cache.this' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cache/Redis/io-p-redis-common'

# bash terraform.sh import prod 'module.redis_common_backup.azurerm_storage_account.this' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Storage/storageAccounts/iopstredis'

# bash terraform.sh import prod 'module.assets_cdn.azurerm_storage_account.this' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Storage/storageAccounts/iopstcdnassets'

# terraform state rm azurerm_management_lock.assets_cdn_profile

# terraform state rm azurerm_management_lock.assets_cdn_endpoint

# bash terraform.sh import prod 'module.azdoa_snet[0].azurerm_subnet.this' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common/subnets/azure-devops'

# bash terraform.sh import prod 'azurerm_private_dns_zone_virtual_network_link.servicebus_private_vnet_common' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-evt-rg/providers/Microsoft.Network/privateDnsZones/privatelink.servicebus.windows.net/virtualNetworkLinks/io-p-evh-ns-private-dns-zone-link-01'

# terraform state rm 'module.event_hub.azurerm_private_dns_zone.eventhub[0]'

# terraform state rm 'module.event_hub.azurerm_private_dns_zone_virtual_network_link.eventhub[0]'

### Step 2

# bash terraform.sh import prod 'module.storage_api.azurerm_storage_account.this' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.Storage/storageAccounts/iopstapi'

# bash terraform.sh import prod 'azurerm_storage_container.storage_api_message_content' 'https://iopstapi.blob.core.windows.net/message-content'

# bash terraform.sh import prod 'azurerm_storage_container.storage_api_cached' 'https://iopstapi.blob.core.windows.net/cached'

# bash terraform.sh import prod 'azurerm_storage_table.storage_api_subscriptionsfeedbyday' "https://iopstapi.table.core.windows.net/Tables('SubscriptionsFeedByDay')"

# bash terraform.sh import prod 'azurerm_storage_table.storage_api_faileduserdataprocessing' "https://iopstapi.table.core.windows.net/Tables('FailedUserDataProcessing')"

# bash terraform.sh import prod 'azurerm_storage_table.storage_api_validationtokens' "https://iopstapi.table.core.windows.net/Tables('ValidationTokens')"

# bash terraform.sh import prod 'module.storage_api_replica.azurerm_storage_account.this' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.Storage/storageAccounts/iopstapireplica'

### Step 3

# bash terraform.sh import prod 'module.nat_gateway.azurerm_nat_gateway.this' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/natGateways/io-p-natgw'

# bash terraform.sh import prod 'module.nat_gateway.azurerm_public_ip.this[0]' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/publicIPAddresses/io-p-natgw-pip-01'

# bash terraform.sh import prod 'module.nat_gateway.azurerm_public_ip.this[1]' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/publicIPAddresses/io-p-natgw-pip-02'

# bash terraform.sh import prod 'module.nat_gateway.azurerm_nat_gateway_public_ip_association.this[0]' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/natGateways/io-p-natgw|/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/publicIPAddresses/io-p-natgw-pip-01'

# bash terraform.sh import prod 'module.nat_gateway.azurerm_nat_gateway_public_ip_association.this[1]' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/natGateways/io-p-natgw|/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/publicIPAddresses/io-p-natgw-pip-02'

# bash terraform.sh import prod 'azurerm_subnet_nat_gateway_association.app_backendl1_snet' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common/subnets/appbackendl1'

# bash terraform.sh import prod 'azurerm_subnet_nat_gateway_association.app_backendl2_snet' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common/subnets/appbackendl2'

# bash terraform.sh import prod 'azurerm_subnet_nat_gateway_association.app_backendli_snet' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common/subnets/appbackendli'

# bash terraform.sh import prod 'azurerm_subnet_nat_gateway_association.function_eucovidcert_snet' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common/subnets/io-p-eucovidcert-snet'

# bash terraform.sh import prod 'azurerm_subnet_nat_gateway_association.cgn_snet' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common/subnets/io-p-cgn-snet'
