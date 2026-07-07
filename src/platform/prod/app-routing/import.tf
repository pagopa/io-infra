# Use this file to import the wanted resources inside the state file, 
# remember to cleanup the import code blocks with a separate PR once the import has been completed successfully.
# Here is the documentation which explains how to use the import code block: https://developer.hashicorp.com/terraform/language/block/import

# APPLICATION GATEWAY

import {
  to = dx_available_subnet_cidr.next_cidr_snet_agw
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Network/virtualNetworks/io-p-itn-common-vnet-01/subnets/io-p-itn-agw-snet-01"
}

import {
  to = module.application_gateway_itn.azurerm_application_gateway.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Network/applicationGateways/io-p-itn-agw-01"
}

import {
  to = module.application_gateway_itn.azurerm_key_vault_access_policy.app_gateway_policy
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-sec-rg/providers/Microsoft.KeyVault/vaults/io-p-kv/objectId/bcfddacf-bcf5-44f4-b0b5-4284a1eeb8a3"
}

import {
  to = module.application_gateway_itn.azurerm_key_vault_access_policy.app_gateway_policy_common
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.KeyVault/vaults/io-p-kv-common/objectId/bcfddacf-bcf5-44f4-b0b5-4284a1eeb8a3"
}

import {
  to = module.application_gateway_itn.azurerm_key_vault_access_policy.app_gateway_policy_ioweb
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-ioweb-sec-rg/providers/Microsoft.KeyVault/vaults/io-p-ioweb-kv/objectId/bcfddacf-bcf5-44f4-b0b5-4284a1eeb8a3"
}

import {
  to = module.application_gateway_itn.azurerm_monitor_metric_alert.this["backend_pools_status"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/metricAlerts/io-p-itn-agw-01-BACKEND_POOLS_STATUS"
}

import {
  to = module.application_gateway_itn.azurerm_monitor_metric_alert.this["compute_units_usage"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/metricAlerts/io-p-itn-agw-01-COMPUTE_UNITS_USAGE"
}

import {
  to = module.application_gateway_itn.azurerm_monitor_metric_alert.this["failed_requests"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/metricAlerts/io-p-itn-agw-01-FAILED_REQUESTS"
}

import {
  to = module.application_gateway_itn.azurerm_monitor_metric_alert.this["response_time"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/metricAlerts/io-p-itn-agw-01-RESPONSE_TIME"
}

import {
  to = module.application_gateway_itn.azurerm_monitor_metric_alert.this["total_requests"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/metricAlerts/io-p-itn-agw-01-TOTAL_REQUESTS"
}

import {
  to = module.application_gateway_itn.azurerm_public_ip.agw
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Network/publicIPAddresses/io-p-itn-agw-pip-01"
}

import {
  to = module.application_gateway_itn.azurerm_subnet.agw
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Network/virtualNetworks/io-p-itn-common-vnet-01/subnets/io-p-itn-agw-snet-01"
}

import {
  to = module.application_gateway_itn.azurerm_user_assigned_identity.appgateway
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ManagedIdentity/userAssignedIdentities/io-p-itn-agw-id-01"
}

import {
  to = module.application_gateway_itn.azurerm_web_application_firewall_policy.agw
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Network/applicationGatewayWebApplicationFirewallPolicies/io-p-itn-agw-waf-01"
}

import {
  to = module.application_gateway_itn.azurerm_web_application_firewall_policy.app
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Network/applicationGatewayWebApplicationFirewallPolicies/io-p-itn-agw-api-app-waf-01"
}

import {
  to = module.application_gateway_itn.module.app_gw_ioweb_kv.module.key_vault.azurerm_role_assignment.certificates["io-p-itn-ioweb-rg-01|io-p-itn-ioweb-kv-01|reader"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-ioweb-rg-01/providers/Microsoft.KeyVault/vaults/io-p-itn-ioweb-kv-01/providers/Microsoft.Authorization/roleAssignments/9107ab00-34e4-1cbc-10b9-152244b91b6a"
}