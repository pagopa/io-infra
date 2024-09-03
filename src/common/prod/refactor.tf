#######################
# Application Gateway #
#######################
import {
  to = module.application_gateway_weu.module.app_gw.azurerm_application_gateway.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/applicationGateways/io-p-appgateway"
}

import {
  to = module.application_gateway_weu.module.appgateway_snet.azurerm_subnet.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common/subnets/io-p-appgateway-snet"
}

import {
  to = module.application_gateway_weu.azurerm_user_assigned_identity.appgateway
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-sec-rg/providers/Microsoft.ManagedIdentity/userAssignedIdentities/io-p-appgateway-identity"
}

import {
  to = module.application_gateway_weu.azurerm_public_ip.appgateway_public_ip
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/publicIPAddresses/io-p-appgateway-pip"
}

import {
  to = module.application_gateway_weu.azurerm_web_application_firewall_policy.api_app
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/applicationGatewayWebApplicationFirewallPolicies/io-p-waf-appgateway-api-app-policy"
}

import {
  to = module.application_gateway_weu.module.app_gw.azurerm_monitor_metric_alert.this["backend_pools_status"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Insights/metricAlerts/io-p-appgateway-BACKEND_POOLS_STATUS"
}

import {
  to = module.application_gateway_weu.module.app_gw.azurerm_monitor_metric_alert.this["compute_units_usage"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Insights/metricAlerts/io-p-appgateway-COMPUTE_UNITS_USAGE"
}

import {
  to = module.application_gateway_weu.module.app_gw.azurerm_monitor_metric_alert.this["response_time"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Insights/metricAlerts/io-p-appgateway-RESPONSE_TIME"
}

import {
  to = module.application_gateway_weu.module.app_gw.azurerm_monitor_metric_alert.this["total_requests"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Insights/metricAlerts/io-p-appgateway-TOTAL_REQUESTS"
}

import {
  to = module.application_gateway_weu.module.app_gw.azurerm_monitor_metric_alert.this["failed_requests"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Insights/metricAlerts/io-p-appgateway-FAILED_REQUESTS"
}

import {
  to = module.application_gateway_weu.azurerm_key_vault_access_policy.app_gateway_policy
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-sec-rg/providers/Microsoft.KeyVault/vaults/io-p-kv/objectId/a60d22cc-bf71-4563-a7a5-e6ca43a42487"
}

import {
  to = module.application_gateway_weu.azurerm_key_vault_access_policy.app_gateway_policy_common
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.KeyVault/vaults/io-p-kv-common/objectId/a60d22cc-bf71-4563-a7a5-e6ca43a42487"
}

import {
  to = module.application_gateway_weu.azurerm_key_vault_access_policy.app_gateway_policy_ioweb
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-ioweb-sec-rg/providers/Microsoft.KeyVault/vaults/io-p-ioweb-kv/objectId/a60d22cc-bf71-4563-a7a5-e6ca43a42487"
}

import {
  to = module.application_gateway_weu.azurerm_key_vault_access_policy.app_gw_uai_kvreader_common
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.KeyVault/vaults/io-p-kv-common/objectId/ef7e473e-41eb-4f7f-b37c-730d02882cb2"
}