#!/bin/bash

bash terraform.sh init prod

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
