import {
  to = module.app_backend_weu["l2"].module.appservice_app_backend_slot_staging.azurerm_linux_web_app_slot.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendl2/slots/staging"
}

import {
  to = module.app_backend_weu["l2"].module.appservice_app_backend_slot_staging.azurerm_app_service_slot_virtual_network_swift_connection.app_service_virtual_network_swift_connection[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendl2/slots/staging/config/virtualNetwork"
}

import {
  to = module.app_backend_weu["l2"].module.appservice_app_backend.azurerm_service_plan.this[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/serverFarms/io-p-plan-appappbackendl2"
}

import {
  to = module.app_backend_weu["l2"].module.appservice_app_backend.azurerm_linux_web_app.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendl2"
}

import {
  to = module.app_backend_weu["l2"].module.appservice_app_backend.azurerm_app_service_virtual_network_swift_connection.app_service_virtual_network_swift_connection[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendl2/config/virtualNetwork"
}

import {
  to = module.app_backend_weu["l2"].azurerm_application_insights_standard_web_test.web_tests
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/io-p-app-appbackendl2.azurewebsites.net-test-io-p-ai-common"
}

import {
  to = module.app_backend_weu["l2"].azurerm_monitor_metric_alert.metric_alerts
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/io-p-app-appbackendl2.azurewebsites.net-test-io-p-ai-common"
}

import {
  to = module.app_backend_weu["l2"].azurerm_subnet_nat_gateway_association.snet["/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/natGateways/io-p-natgw"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common/subnets/appbackendl2"
}

import {
  to = module.app_backend_weu["l2"].azurerm_subnet.snet
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common/subnets/appbackendl2"
}

import {
  to = module.app_backend_weu["l2"].azurerm_monitor_metric_alert.too_many_http_5xx
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Insights/metricAlerts/[IO-COMMONS | io-p-app-appbackendl2] Too many 5xx"
}

#### L1
import {
  to = module.app_backend_weu["l1"].module.appservice_app_backend_slot_staging.azurerm_linux_web_app_slot.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendl1/slots/staging"
}

import {
  to = module.app_backend_weu["l1"].module.appservice_app_backend_slot_staging.azurerm_app_service_slot_virtual_network_swift_connection.app_service_virtual_network_swift_connection[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendl1/slots/staging/config/virtualNetwork"
}

import {
  to = module.app_backend_weu["l1"].module.appservice_app_backend.azurerm_service_plan.this[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/serverFarms/io-p-plan-appappbackendl1"
}

import {
  to = module.app_backend_weu["l1"].module.appservice_app_backend.azurerm_linux_web_app.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendl1"
}

import {
  to = module.app_backend_weu["l1"].module.appservice_app_backend.azurerm_app_service_virtual_network_swift_connection.app_service_virtual_network_swift_connection[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendl1/config/virtualNetwork"
}

import {
  to = module.app_backend_weu["l1"].azurerm_application_insights_standard_web_test.web_tests
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/io-p-app-appbackendl1.azurewebsites.net-test-io-p-ai-common"
}

import {
  to = module.app_backend_weu["l1"].azurerm_monitor_metric_alert.metric_alerts
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/io-p-app-appbackendl1.azurewebsites.net-test-io-p-ai-common"
}

import {
  to = module.app_backend_weu["l1"].azurerm_subnet_nat_gateway_association.snet["/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/natGateways/io-p-natgw"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common/subnets/appbackendl1"
}

import {
  to = module.app_backend_weu["l1"].azurerm_subnet.snet
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common/subnets/appbackendl1"
}

import {
  to = module.app_backend_weu["l1"].azurerm_monitor_metric_alert.too_many_http_5xx
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Insights/metricAlerts/[IO-COMMONS | io-p-app-appbackendl1] Too many 5xx"
}

import {
  to = azurerm_resource_group.rg_linux
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux"
}

# Secrets

import {
  to = module.app_backend_weu["l1"].azurerm_key_vault_secret.appbackend_THIRD_PARTY_CONFIG_LIST[0]
  id = "https://io-p-kv-common.vault.azure.net/secrets/appbackend-THIRD-PARTY-CONFIG-LIST/e6b2c38800d64c07a118290fd2daedb1"
}

import {
  to = module.app_backend_weu["l1"].azurerm_key_vault_secret.appbackend_LOLLIPOP_ASSERTIONS_STORAGE[0]
  id = "https://io-p-kv-common.vault.azure.net/secrets/appbackend-LOLLIPOP-ASSERTIONS-STORAGE/5a032482d59442a097106b1b18f1d38b"
}

import {
  to = module.app_backend_weu["l1"].azurerm_key_vault_secret.appbackend-USERS-LOGIN-STORAGE[0]
  id = "https://io-p-kv-common.vault.azure.net/secrets/appbackend-USERS-LOGIN-STORAGE/cbba93dd11a742c6b26d4111d392936c"
}

import {
  to = module.app_backend_weu["l1"].azurerm_key_vault_secret.appbackend-SPID-LOG-STORAGE[0]
  id = "https://io-p-kv-common.vault.azure.net/secrets/appbackend-SPID-LOG-STORAGE/7ffef071722d4f4cb68be125b981b78a"
}

import {
  to = module.app_backend_weu["l1"].azurerm_key_vault_secret.appbackend-REDIS-PASSWORD[0]
  id = "https://io-p-kv-common.vault.azure.net/secrets/appbackend-REDIS-PASSWORD/dc77ed68f6bd4738af5466f094deeb0b"
}

import {
  to = module.app_backend_weu["l1"].azurerm_key_vault_secret.appbackend-PUSH-NOTIFICATIONS-STORAGE[0]
  id = "https://io-p-kv-common.vault.azure.net/secrets/appbackend-PUSH-NOTIFICATIONS-STORAGE/ddbe5907e71b4a52b46bc4a8ceff9e34"
}


import {
  to = module.app_backend_weu["l1"].azurerm_key_vault_secret.appbackend-NORIFICATIONS-STORAGE[0]
  id = "https://io-p-kv-common.vault.azure.net/secrets/appbackend-NORIFICATIONS-STORAGE/abe9abfd98a944c5adccd932e4000373"
}