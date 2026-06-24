# Use this file to import the wanted resources inside the state file, 
# remember to cleanup the import code blocks with a separate PR once the import has been completed successfully.
# Here is the documentation which explains how to use the import code block: https://developer.hashicorp.com/terraform/language/block/import

# APIM

import {
  to = module.apim_itn.azurerm_key_vault_access_policy.apim_kv_policy
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-sec-rg/providers/Microsoft.KeyVault/vaults/io-p-kv/objectId/bef9fb72-7a41-44d1-9819-2f0b5020bad6"
}

import {
  to = module.apim_itn.azurerm_key_vault_access_policy.common
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.KeyVault/vaults/io-p-kv-common/objectId/bef9fb72-7a41-44d1-9819-2f0b5020bad6"
}

import {
  to = module.apim_itn.azurerm_public_ip.apim
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Network/publicIPAddresses/io-p-itn-apim-pip-01"
}

import {
  to = module.apim_itn.azurerm_subnet.apim
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Network/virtualNetworks/io-p-itn-common-vnet-01/subnets/io-p-itn-apim-snet-01"
}

import {
  to = module.apim_itn.module.apim.azurerm_api_management.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-apim-01"
}

import {
  to = module.apim_itn.module.apim.azurerm_api_management_diagnostic.applicationinsights[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-apim-01/diagnostics/applicationinsights"
}

import {
  to = module.apim_itn.module.apim.azurerm_api_management_logger.this[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-apim-01/loggers/io-p-itn-apim-01-logger"
}

import {
  to = module.apim_itn.module.apim.azurerm_monitor_autoscale_setting.this[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/autoScaleSettings/io-p-itn-apim-as-01"
}

import {
  to = module.apim_itn.module.apim.azurerm_monitor_metric_alert.this["capacity"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/metricAlerts/io-p-itn-apim-01-CAPACITY"
}

import {
  to = module.apim_itn.module.apim.azurerm_monitor_metric_alert.this["duration"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/metricAlerts/io-p-itn-apim-01-DURATION"
}

import {
  to = module.apim_itn.module.apim.azurerm_monitor_metric_alert.this["requests_failed"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/metricAlerts/io-p-itn-apim-01-REQUESTS_FAILED"
}

import {
  to = module.apim_itn.module.apim.azurerm_network_security_group.nsg_apim
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Network/networkSecurityGroups/io-p-itn-apim-nsg-01"
}

import {
  to = module.apim_itn.module.apim.azurerm_private_dns_a_record.apim_azure_api_net[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/azure-api.net/A/io-p-itn-apim-01"
}

import {
  to = module.apim_itn.module.apim.azurerm_private_dns_a_record.apim_management_azure_api_net[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/management.azure-api.net/A/io-p-itn-apim-01"
}

import {
  to = module.apim_itn.module.apim.azurerm_private_dns_a_record.apim_scm_azure_api_net[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/scm.azure-api.net/A/io-p-itn-apim-01"
}

import {
  to = module.apim_itn.module.apim.azurerm_subnet_network_security_group_association.snet_nsg
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Network/virtualNetworks/io-p-itn-common-vnet-01/subnets/io-p-itn-apim-snet-01"
}

import {
  to = module.apim_itn.module.iam_adgroup_auth_admins.module.apim.azurerm_role_assignment.this["io-p-itn-common-rg-01|io-p-itn-apim-01|owner"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-apim-01/providers/Microsoft.Authorization/roleAssignments/9fbdeab6-f2d7-0477-96a0-d736e2b9e318"
}

import {
  to = module.apim_itn.module.iam_adgroup_bonus_admins.module.apim.azurerm_role_assignment.this["io-p-itn-common-rg-01|io-p-itn-apim-01|owner"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-apim-01/providers/Microsoft.Authorization/roleAssignments/b284d637-714a-589b-352f-af5c0e1f46f2"
}

import {
  to = module.apim_itn.module.iam_adgroup_com_admins.module.apim.azurerm_role_assignment.this["io-p-itn-common-rg-01|io-p-itn-apim-01|owner"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-apim-01/providers/Microsoft.Authorization/roleAssignments/c9374d73-248e-5ba1-63e3-d8fba6a5dae6"
}

import {
  to = module.apim_itn.module.iam_adgroup_svc_admins.module.apim.azurerm_role_assignment.this["io-p-itn-common-rg-01|io-p-itn-apim-01|owner"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-apim-01/providers/Microsoft.Authorization/roleAssignments/e9593912-5289-56da-1699-8fe614ff305a"
}

import {
  to = module.apim_itn.module.iam_adgroup_wallet_admins.module.apim.azurerm_role_assignment.this["io-p-itn-common-rg-01|io-p-itn-apim-01|owner"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-apim-01/providers/Microsoft.Authorization/roleAssignments/518369c0-cf94-04c1-5847-8f862d98979f"
}

import {
  to = module.apim_itn.module.iam_cgn_pe_backend_app_01.module.apim.azurerm_role_assignment.this["io-p-itn-common-rg-01|io-p-itn-apim-01|owner"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-apim-01/providers/Microsoft.Authorization/roleAssignments/384b44ea-d7f2-05d1-d5ad-142de79d3a54"
}

# APPLICATION GATEWAY

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

# PLATFORM API GATEWAY

import {
  to = module.platform_api_gateway_apim_itn.azapi_resource.app_backend_pool
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/backends/app-backend-pool"
}

import {
  to = module.platform_api_gateway_apim_itn.azurerm_api_management_api.platform_internal
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/apis/io-p-platform-internal-api;rev=1"
}

import {
  to = module.platform_api_gateway_apim_itn.azurerm_api_management_api.platform_legacy
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/apis/io-p-platform-legacy-api;rev=1"
}

import {
  to = module.platform_api_gateway_apim_itn.azurerm_api_management_api_operation_policy.platform_internal_delete_session
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/apis/io-p-platform-internal-api/operations/deleteSession"
}

import {
  to = module.platform_api_gateway_apim_itn.azurerm_api_management_api_operation_policy.platform_internal_get_cached_session
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/apis/io-p-platform-internal-api/operations/getCachedSession"
}

import {
  to = module.platform_api_gateway_apim_itn.azurerm_api_management_api_operation_policy.platform_legacy_get_ping
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/apis/io-p-platform-legacy-api/operations/getPing"
}

import {
  to = module.platform_api_gateway_apim_itn.azurerm_api_management_api_operation_policy.platform_legacy_get_ping_head
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/apis/io-p-platform-legacy-api/operations/getPingHead"
}

import {
  to = module.platform_api_gateway_apim_itn.azurerm_api_management_api_operation_policy.platform_legacy_get_server_info
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/apis/io-p-platform-legacy-api/operations/getServerInfo"
}

import {
  to = module.platform_api_gateway_apim_itn.azurerm_api_management_api_operation_policy.platform_legacy_get_services_status
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/apis/io-p-platform-legacy-api/operations/getServicesStatus"
}

import {
  to = module.platform_api_gateway_apim_itn.azurerm_api_management_api_operation_policy.platform_legacy_get_services_status_head
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/apis/io-p-platform-legacy-api/operations/getServicesStatusHead"
}

import {
  to = module.platform_api_gateway_apim_itn.azurerm_api_management_api_operation_policy.platform_legacy_redirect
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/apis/io-p-platform-legacy-api/operations/Redirect"
}

import {
  to = module.platform_api_gateway_apim_itn.azurerm_api_management_api_policy.platform_internal
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/apis/io-p-platform-internal-api"
}

import {
  to = module.platform_api_gateway_apim_itn.azurerm_api_management_api_policy.platform_legacy
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/apis/io-p-platform-legacy-api"
}

import {
  to = module.platform_api_gateway_apim_itn.azurerm_api_management_api_version_set.platform_internal
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/apiVersionSets/io-p-platform-internal-apis"
}

import {
  to = module.platform_api_gateway_apim_itn.azurerm_api_management_backend.app_backend_backends[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/backends/app-backend-1"
}

import {
  to = module.platform_api_gateway_apim_itn.azurerm_api_management_backend.app_backend_backends["1"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/backends/app-backend-2"
}

import {
  to = module.platform_api_gateway_apim_itn.azurerm_api_management_named_value.platform_api_gateway_hostname_internal
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/namedValues/platform-api-gateway-hostname-internal"
}

import {
  to = module.platform_api_gateway_apim_itn.azurerm_api_management_named_value.session_manager_introspection_url
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/namedValues/session-manager-introspection-url"
}

import {
  to = module.platform_api_gateway_apim_itn.azurerm_api_management_named_value.session_token_cache_prefix
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/namedValues/session-token-cache-prefix"
}

import {
  to = module.platform_api_gateway_apim_itn.azurerm_api_management_policy_fragment.auth
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/policyFragments/ioapp-authenticated"
}

import {
  to = module.platform_api_gateway_apim_itn.azurerm_api_management_policy_fragment.auth_cache
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/policyFragments/ioapp-authenticated-cache"
}

import {
  to = module.platform_api_gateway_apim_itn.azurerm_api_management_product.auth
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/products/io-auth"
}

import {
  to = module.platform_api_gateway_apim_itn.azurerm_api_management_product.institutions
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/products/io-institutions"
}

import {
  to = module.platform_api_gateway_apim_itn.azurerm_api_management_product.platform
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/products/io-platform"
}

import {
  to = module.platform_api_gateway_apim_itn.azurerm_api_management_product.sign
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/products/io-sign"
}

import {
  to = module.platform_api_gateway_apim_itn.azurerm_api_management_product_api.platform_platform_internal
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/products/io-platform/apis/io-p-platform-internal-api"
}

import {
  to = module.platform_api_gateway_apim_itn.azurerm_api_management_product_api.platform_platform_legacy
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/products/io-platform/apis/io-p-platform-legacy-api"
}

import {
  to = module.platform_api_gateway_apim_itn.azurerm_api_management_product_policy.auth
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/products/io-auth"
}

import {
  to = module.platform_api_gateway_apim_itn.azurerm_api_management_product_policy.institutions
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/products/io-institutions"
}

import {
  to = module.platform_api_gateway_apim_itn.azurerm_api_management_product_policy.platform
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/products/io-platform"
}

import {
  to = module.platform_api_gateway_apim_itn.azurerm_api_management_product_policy.sign
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/products/io-sign"
}

import {
  to = module.platform_api_gateway_apim_itn.azurerm_key_vault_access_policy.platform_api_gateway_kv_policy
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-sec-rg/providers/Microsoft.KeyVault/vaults/io-p-kv/objectId/1ff61bad-d412-44d8-987c-9bd53fb54b84"
}

import {
  to = module.platform_api_gateway_apim_itn.azurerm_subnet.platform_api_gateway
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Network/virtualNetworks/io-p-itn-common-vnet-01/subnets/io-p-itn-platform-api-gateway-snet-01"
}

import {
  to = module.platform_api_gateway_apim_itn.module.iam_adgroup["12a48460-7d95-4d91-ab0a-1d19008aac2c"].module.apim.azurerm_role_assignment.this["io-p-itn-common-rg-01|io-p-itn-platform-api-gateway-apim-01|owner"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/providers/Microsoft.Authorization/roleAssignments/39831ed1-c915-f3f1-0487-a06cdecd28b2"
}

import {
  to = module.platform_api_gateway_apim_itn.module.iam_adgroup["1def1c67-aed2-449c-96d5-0aeae24a1597"].module.apim.azurerm_role_assignment.this["io-p-itn-common-rg-01|io-p-itn-platform-api-gateway-apim-01|owner"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/providers/Microsoft.Authorization/roleAssignments/56223c5f-3db4-5128-a783-6cec0429c088"
}

import {
  to = module.platform_api_gateway_apim_itn.module.iam_adgroup["41a75ef2-d909-4adc-b746-36ff057560a1"].module.apim.azurerm_role_assignment.this["io-p-itn-common-rg-01|io-p-itn-platform-api-gateway-apim-01|owner"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/providers/Microsoft.Authorization/roleAssignments/5ea09bd7-2309-3468-2606-85a9f7e70a2e"
}

import {
  to = module.platform_api_gateway_apim_itn.module.iam_adgroup["831e5214-2f68-4a13-b25f-7bec962c7e1b"].module.apim.azurerm_role_assignment.this["io-p-itn-common-rg-01|io-p-itn-platform-api-gateway-apim-01|owner"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/providers/Microsoft.Authorization/roleAssignments/d610cc33-e050-4223-99df-2e9727bd282e"
}

import {
  to = module.platform_api_gateway_apim_itn.module.iam_adgroup["912c0ba1-90b5-47eb-83f7-bf1e1294cd5c"].module.apim.azurerm_role_assignment.this["io-p-itn-common-rg-01|io-p-itn-platform-api-gateway-apim-01|owner"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/providers/Microsoft.Authorization/roleAssignments/0c2a3830-1b75-dcc2-3b48-2e4cf9c076f0"
}

import {
  to = module.platform_api_gateway_apim_itn.module.iam_adgroup["a0ed72be-f9f9-407e-bf25-91761f8d3de7"].module.apim.azurerm_role_assignment.this["io-p-itn-common-rg-01|io-p-itn-platform-api-gateway-apim-01|owner"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/providers/Microsoft.Authorization/roleAssignments/c378cc8a-1f2c-42aa-3fb7-f0fa0874d052"
}

import {
  to = module.platform_api_gateway_apim_itn.module.iam_adgroup["ef6b556d-4d33-4467-ad9d-6b5540cbde6b"].module.apim.azurerm_role_assignment.this["io-p-itn-common-rg-01|io-p-itn-platform-api-gateway-apim-01|owner"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/providers/Microsoft.Authorization/roleAssignments/f5081330-6fed-7dcf-0214-17930eab972b"
}

import {
  to = module.platform_api_gateway_apim_itn.module.iam_adgroup["fc9dd549-51dc-4655-b1ce-7429617e37f8"].module.apim.azurerm_role_assignment.this["io-p-itn-common-rg-01|io-p-itn-platform-api-gateway-apim-01|owner"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/providers/Microsoft.Authorization/roleAssignments/a60f560e-d107-2bd4-170e-d6ab0546fdb2"
}

import {
  to = module.platform_api_gateway_apim_itn.module.platform_api_gateway.azurerm_api_management.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01"
}

import {
  to = module.platform_api_gateway_apim_itn.module.platform_api_gateway.azurerm_api_management_diagnostic.applicationinsights[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/diagnostics/applicationinsights"
}

import {
  to = module.platform_api_gateway_apim_itn.module.platform_api_gateway.azurerm_api_management_logger.this[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01/loggers/io-p-itn-platform-api-gateway-apim-01-logger"
}

import {
  to = module.platform_api_gateway_apim_itn.module.platform_api_gateway.azurerm_monitor_autoscale_setting.this[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/autoScaleSettings/io-p-itn-platform-api-gateway-apim-as-01"
}

import {
  to = module.platform_api_gateway_apim_itn.module.platform_api_gateway.azurerm_monitor_diagnostic_setting.apim[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-platform-api-gateway-apim-01|io-p-itn-platform-api-gateway-apim-01-diagnostic"
}

import {
  to = module.platform_api_gateway_apim_itn.module.platform_api_gateway.azurerm_monitor_metric_alert.this["capacity"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/metricAlerts/io-p-itn-platform-api-gateway-apim-01-CAPACITY"
}

import {
  to = module.platform_api_gateway_apim_itn.module.platform_api_gateway.azurerm_monitor_metric_alert.this["duration"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/metricAlerts/io-p-itn-platform-api-gateway-apim-01-DURATION"
}

import {
  to = module.platform_api_gateway_apim_itn.module.platform_api_gateway.azurerm_monitor_metric_alert.this["requests_failed"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/metricAlerts/io-p-itn-platform-api-gateway-apim-01-REQUESTS_FAILED"
}

import {
  to = module.platform_api_gateway_apim_itn.module.platform_api_gateway.azurerm_network_security_group.nsg_apim
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Network/networkSecurityGroups/io-p-itn-platform-api-gateway-apim-nsg-01"
}

import {
  to = module.platform_api_gateway_apim_itn.module.platform_api_gateway.azurerm_private_dns_a_record.apim_azure_api_net[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/azure-api.net/A/io-p-itn-platform-api-gateway-apim-01"
}

import {
  to = module.platform_api_gateway_apim_itn.module.platform_api_gateway.azurerm_private_dns_a_record.apim_management_azure_api_net[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/management.azure-api.net/A/io-p-itn-platform-api-gateway-apim-01"
}

import {
  to = module.platform_api_gateway_apim_itn.module.platform_api_gateway.azurerm_private_dns_a_record.apim_scm_azure_api_net[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/scm.azure-api.net/A/io-p-itn-platform-api-gateway-apim-01"
}

import {
  to = module.platform_api_gateway_apim_itn.module.platform_api_gateway.azurerm_subnet_network_security_group_association.snet_nsg
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Network/virtualNetworks/io-p-itn-common-vnet-01/subnets/io-p-itn-platform-api-gateway-snet-01"
}