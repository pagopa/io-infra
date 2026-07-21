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
