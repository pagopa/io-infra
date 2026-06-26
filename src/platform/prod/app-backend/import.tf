# Use this file to import the wanted resources inside the state file, 
# remember to cleanup the import code blocks with a separate PR once the import has been completed successfully.
# Here is the documentation which explains how to use the import code block: https://developer.hashicorp.com/terraform/language/block/import

import {
  to = module.app_backend_weu["1"].azurerm_application_insights_standard_web_test.web_tests
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/io-p-app-appbackendl1.azurewebsites.net-test-io-p-ai-common"
}

import {
  to = module.app_backend_weu["1"].azurerm_key_vault_access_policy.app_backend_kv_common
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.KeyVault/vaults/io-p-kv-common/objectId/413a20d7-497c-441f-a6f4-4bf8d5cf8451"
}

import {
  to = module.app_backend_weu["1"].azurerm_key_vault_access_policy.appservice_app_backend_slot_staging_kv_common
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.KeyVault/vaults/io-p-kv-common/objectId/94e3252a-79b5-495b-a693-e965167343eb"
}

import {
  to = module.app_backend_weu["1"].azurerm_key_vault_secret.appbackend-NORIFICATIONS-STORAGE[0]
  id = "https://io-p-kv-common.vault.azure.net/secrets/appbackend-NORIFICATIONS-STORAGE/abe9abfd98a944c5adccd932e4000373"
}

import {
  to = module.app_backend_weu["1"].azurerm_key_vault_secret.appbackend-REDIS-PASSWORD[0]
  id = "https://io-p-kv-common.vault.azure.net/secrets/appbackend-REDIS-PASSWORD/dc77ed68f6bd4738af5466f094deeb0b"
}

import {
  to = module.app_backend_weu["1"].azurerm_key_vault_secret.appbackend-SPID-LOG-STORAGE[0]
  id = "https://io-p-kv-common.vault.azure.net/secrets/appbackend-SPID-LOG-STORAGE/7ffef071722d4f4cb68be125b981b78a"
}

import {
  to = module.app_backend_weu["1"].azurerm_key_vault_secret.appbackend-USERS-LOGIN-STORAGE[0]
  id = "https://io-p-kv-common.vault.azure.net/secrets/appbackend-USERS-LOGIN-STORAGE/cbba93dd11a742c6b26d4111d392936c"
}

import {
  to = module.app_backend_weu["1"].azurerm_key_vault_secret.appbackend_THIRD_PARTY_CONFIG_LIST[0]
  id = "https://io-p-kv-common.vault.azure.net/secrets/appbackend-THIRD-PARTY-CONFIG-LIST/8d9d4298606747b7ba147d5d5eade79b"
}

import {
  to = module.app_backend_weu["1"].azurerm_monitor_metric_alert.metric_alerts
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/io-p-app-appbackendl1.azurewebsites.net-test-io-p-ai-common"
}

import {
  to = module.app_backend_weu["1"].azurerm_monitor_metric_alert.too_many_http_5xx
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Insights/metricAlerts/[IO-COMMONS | io-p-app-appbackendl1] Too many 5xx"
}

import {
  to = module.app_backend_weu["1"].azurerm_private_endpoint.app_backend
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Network/privateEndpoints/io-p-weu-appbackend-app-pep-01"
}

import {
  to = module.app_backend_weu["1"].azurerm_private_endpoint.app_backend_staging
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Network/privateEndpoints/io-p-weu-appbackend-staging-app-pep-01"
}

import {
  to = module.app_backend_weu["1"].azurerm_role_assignment.appbackend_adgroup_auth_admins
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendl1/providers/Microsoft.Authorization/roleAssignments/0c20ae37-65ca-5a68-f437-4397f8915d10"
}

import {
  to = module.app_backend_weu["1"].azurerm_role_assignment.appbackend_adgroup_bonus_admins
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendl1/providers/Microsoft.Authorization/roleAssignments/eeeb799a-551a-2e33-42f0-74adbe94bee5"
}

import {
  to = module.app_backend_weu["1"].azurerm_role_assignment.appbackend_adgroup_com_admins
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendl1/providers/Microsoft.Authorization/roleAssignments/4fcc5ae7-7ac9-b69f-7cc1-2f7b6f9e3403"
}

import {
  to = module.app_backend_weu["1"].azurerm_role_assignment.appbackend_adgroup_svc_admins
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendl1/providers/Microsoft.Authorization/roleAssignments/64401477-d0c5-13b6-9bb8-aad19497b969"
}

import {
  to = module.app_backend_weu["1"].azurerm_role_assignment.appbackend_adgroup_wallet_admins
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendl1/providers/Microsoft.Authorization/roleAssignments/c0f22e0a-2bdd-1ebc-f8bd-f7a55bf27e07"
}

import {
  to = module.app_backend_weu["1"].azurerm_role_assignment.appbackend_staging_adgroup_auth_admins
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendl1/slots/staging/providers/Microsoft.Authorization/roleAssignments/86cb0134-f3a0-92ea-3d26-389932f3c31d"
}

import {
  to = module.app_backend_weu["1"].azurerm_role_assignment.appbackend_staging_adgroup_bonus_admins
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendl1/slots/staging/providers/Microsoft.Authorization/roleAssignments/72dae8ae-743f-d53e-de80-889651f2a9a4"
}

import {
  to = module.app_backend_weu["1"].azurerm_role_assignment.appbackend_staging_adgroup_com_admins
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendl1/slots/staging/providers/Microsoft.Authorization/roleAssignments/a4010839-ba39-c1f5-c693-858be0c99cdf"
}

import {
  to = module.app_backend_weu["1"].azurerm_role_assignment.appbackend_staging_adgroup_svc_admins
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendl1/slots/staging/providers/Microsoft.Authorization/roleAssignments/350d90c2-3319-0446-ea44-9a453187fb69"
}

import {
  to = module.app_backend_weu["1"].azurerm_role_assignment.appbackend_staging_adgroup_wallet_admins
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendl1/slots/staging/providers/Microsoft.Authorization/roleAssignments/dd97021c-7f21-b10e-bdfe-954956c02eca"
}

import {
  to = module.app_backend_weu["1"].azurerm_subnet.snet
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common/subnets/appbackendl1"
}

import {
  to = module.app_backend_weu["1"].azurerm_subnet_nat_gateway_association.snet["/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/natGateways/io-p-natgw"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common/subnets/appbackendl1"
}

import {
  to = module.app_backend_weu["1"].module.appservice_app_backend.azurerm_app_service_virtual_network_swift_connection.app_service_virtual_network_swift_connection[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendl1/config/virtualNetwork"
}

import {
  to = module.app_backend_weu["1"].module.appservice_app_backend.azurerm_linux_web_app.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendl1"
}

import {
  to = module.app_backend_weu["1"].module.appservice_app_backend.azurerm_service_plan.this[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/serverFarms/io-p-plan-appappbackendl1"
}

import {
  to = module.app_backend_weu["1"].module.appservice_app_backend_slot_staging.azurerm_app_service_slot_virtual_network_swift_connection.app_service_virtual_network_swift_connection[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendl1/slots/staging/config/virtualNetwork"
}

import {
  to = module.app_backend_weu["1"].module.appservice_app_backend_slot_staging.azurerm_linux_web_app_slot.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendl1/slots/staging"
}

import {
  to = module.app_backend_weu["2"].azurerm_application_insights_standard_web_test.web_tests
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/io-p-app-appbackendl2.azurewebsites.net-test-io-p-ai-common"
}

import {
  to = module.app_backend_weu["2"].azurerm_key_vault_access_policy.app_backend_kv_common
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.KeyVault/vaults/io-p-kv-common/objectId/ca6d33c4-5eef-4973-9c84-37aa5cdefc9a"
}

import {
  to = module.app_backend_weu["2"].azurerm_key_vault_access_policy.appservice_app_backend_slot_staging_kv_common
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.KeyVault/vaults/io-p-kv-common/objectId/37f6588f-411f-4a39-b1c1-cc83d60cdc5c"
}

import {
  to = module.app_backend_weu["2"].azurerm_monitor_metric_alert.metric_alerts
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/io-p-app-appbackendl2.azurewebsites.net-test-io-p-ai-common"
}

import {
  to = module.app_backend_weu["2"].azurerm_monitor_metric_alert.too_many_http_5xx
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Insights/metricAlerts/[IO-COMMONS | io-p-app-appbackendl2] Too many 5xx"
}

import {
  to = module.app_backend_weu["2"].azurerm_private_endpoint.app_backend
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Network/privateEndpoints/io-p-weu-appbackend-app-pep-02"
}

import {
  to = module.app_backend_weu["2"].azurerm_private_endpoint.app_backend_staging
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Network/privateEndpoints/io-p-weu-appbackend-staging-app-pep-02"
}

import {
  to = module.app_backend_weu["2"].azurerm_role_assignment.appbackend_adgroup_auth_admins
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendl2/providers/Microsoft.Authorization/roleAssignments/4fad2868-61fd-9a79-892a-1381f02a0cde"
}

import {
  to = module.app_backend_weu["2"].azurerm_role_assignment.appbackend_adgroup_bonus_admins
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendl2/providers/Microsoft.Authorization/roleAssignments/afe66b7a-9916-9bad-b3a8-e052fdbee735"
}

import {
  to = module.app_backend_weu["2"].azurerm_role_assignment.appbackend_adgroup_com_admins
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendl2/providers/Microsoft.Authorization/roleAssignments/0607c2ef-81d2-f62b-6475-90169f92f6ea"
}

import {
  to = module.app_backend_weu["2"].azurerm_role_assignment.appbackend_adgroup_svc_admins
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendl2/providers/Microsoft.Authorization/roleAssignments/1b5806af-6be9-7967-f58c-d7fac964fc77"
}

import {
  to = module.app_backend_weu["2"].azurerm_role_assignment.appbackend_adgroup_wallet_admins
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendl2/providers/Microsoft.Authorization/roleAssignments/caba7165-eeaf-6db6-25b1-048b479e86eb"
}

import {
  to = module.app_backend_weu["2"].azurerm_role_assignment.appbackend_staging_adgroup_auth_admins
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendl2/slots/staging/providers/Microsoft.Authorization/roleAssignments/10f9a1f4-70b8-ac62-601d-a27aacc475d1"
}

import {
  to = module.app_backend_weu["2"].azurerm_role_assignment.appbackend_staging_adgroup_bonus_admins
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendl2/slots/staging/providers/Microsoft.Authorization/roleAssignments/56867189-7591-eb06-f160-193c10b547d9"
}

import {
  to = module.app_backend_weu["2"].azurerm_role_assignment.appbackend_staging_adgroup_com_admins
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendl2/slots/staging/providers/Microsoft.Authorization/roleAssignments/d13e8a0e-56bd-08e7-8db6-9bf60394e99d"
}

import {
  to = module.app_backend_weu["2"].azurerm_role_assignment.appbackend_staging_adgroup_svc_admins
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendl2/slots/staging/providers/Microsoft.Authorization/roleAssignments/e5662026-4d7e-aae8-4986-2ecebbd0ebdc"
}

import {
  to = module.app_backend_weu["2"].azurerm_role_assignment.appbackend_staging_adgroup_wallet_admins
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendl2/slots/staging/providers/Microsoft.Authorization/roleAssignments/570e4b0e-4be5-ad2f-3889-8a2af61f7fc4"
}

import {
  to = module.app_backend_weu["2"].azurerm_subnet.snet
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common/subnets/appbackendl2"
}

import {
  to = module.app_backend_weu["2"].azurerm_subnet_nat_gateway_association.snet["/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/natGateways/io-p-natgw"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common/subnets/appbackendl2"
}

import {
  to = module.app_backend_weu["2"].module.appservice_app_backend.azurerm_app_service_virtual_network_swift_connection.app_service_virtual_network_swift_connection[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendl2/config/virtualNetwork"
}

import {
  to = module.app_backend_weu["2"].module.appservice_app_backend.azurerm_linux_web_app.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendl2"
}

import {
  to = module.app_backend_weu["2"].module.appservice_app_backend.azurerm_service_plan.this[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/serverFarms/io-p-plan-appappbackendl2"
}

import {
  to = module.app_backend_weu["2"].module.appservice_app_backend_slot_staging.azurerm_app_service_slot_virtual_network_swift_connection.app_service_virtual_network_swift_connection[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendl2/slots/staging/config/virtualNetwork"
}

import {
  to = module.app_backend_weu["2"].module.appservice_app_backend_slot_staging.azurerm_linux_web_app_slot.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendl2/slots/staging"
}