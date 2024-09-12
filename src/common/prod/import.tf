import {
  to = module.apim_weu.azurerm_network_security_group.apim
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/networkSecurityGroups/io-p-apim-v2-nsg"
}

import {
  to = module.apim_weu.azurerm_public_ip.apim
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/publicIPAddresses/io-p-apim-v2-public-ip"
}

import {
  to = module.apim_weu.azurerm_subnet.apim
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common/subnets/apimv2api"
}

import {
  to = module.apim_weu.azurerm_subnet_network_security_group_association.apim
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common/subnets/apimv2api"
}

import {
  to = module.apim_weu.module.apim_v2.azurerm_api_management.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.ApiManagement/service/io-p-apim-v2-api"
}

import {
  to = module.apim_weu.module.apim_v2.azurerm_api_management_diagnostic.this[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.ApiManagement/service/io-p-apim-v2-api/diagnostics/applicationinsights"
}

import {
  to = module.apim_weu.module.apim_v2.azurerm_api_management_logger.this[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.ApiManagement/service/io-p-apim-v2-api/loggers/io-p-apim-v2-api-logger"
}

import {
  to = module.apim_weu.module.apim_v2.azurerm_monitor_autoscale_setting.this[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.Insights/autoScaleSettings/io-p-apim-v2-api-autoscale"
}

import {
  to = module.apim_weu.module.apim_v2.azurerm_monitor_metric_alert.this["capacity"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.Insights/metricAlerts/io-p-apim-v2-api-CAPACITY"
}

import {
  to = module.apim_weu.module.apim_v2.azurerm_monitor_metric_alert.this["duration"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.Insights/metricAlerts/io-p-apim-v2-api-DURATION"
}

import {
  to = module.apim_weu.module.apim_v2.azurerm_monitor_metric_alert.this["requests_failed"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.Insights/metricAlerts/io-p-apim-v2-api-REQUESTS_FAILED"
}

import {
  to = module.apim_weu.azurerm_key_vault_access_policy.apim_v2_kv_policy
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-sec-rg/providers/Microsoft.KeyVault/vaults/io-p-kv/objectId/5622ec45-ad97-46ae-b2c0-035ad01f70b2"
}

import {
  to = module.apim_weu.azurerm_key_vault_access_policy.v2_common
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.KeyVault/vaults/io-p-kv-common/objectId/5622ec45-ad97-46ae-b2c0-035ad01f70b2"
}

import {
  to = module.apim_weu.azurerm_api_management_subscription.pn_lc_subscription_v2
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.ApiManagement/service/io-p-apim-v2-api/subscriptions/4ab4fd2e-138b-4d2a-98af-0ca4bb23680e"
}

import {
  to = module.apim_weu.azurerm_api_management_user.pn_user_v2
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.ApiManagement/service/io-p-apim-v2-api/users/pnapimuser"
}

import {
  to = module.apim_weu.azurerm_api_management_group_user.pn_user_group_v2
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.ApiManagement/service/io-p-apim-v2-api/groups/apilollipopassertionread/users/pnapimuser"
}
