import {
  to = module.app_backend_li_weu.module.appservice_app_backend.azurerm_service_plan.this[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/serverFarms/io-p-plan-appappbackendli"
}

import {
  to = module.app_backend_li_weu.module.appservice_app_backend.azurerm_linux_web_app.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendli"
}

import {
  to = module.app_backend_li_weu.module.appservice_app_backend.azurerm_app_service_virtual_network_swift_connection.app_service_virtual_network_swift_connection[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendli/config/virtualNetwork"
}

import {
  to = module.app_backend_li_weu.azurerm_subnet_nat_gateway_association.snet["/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/natGateways/io-p-natgw"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common/subnets/appbackendli"
}

import {
  to = module.app_backend_li_weu.azurerm_subnet.snet
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common/subnets/appbackendli"
}

import {
  to = module.app_backend_li_weu.azurerm_monitor_metric_alert.too_many_http_5xx
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Insights/metricAlerts/[IO-COMMONS | io-p-app-appbackendli] Too many 5xx"
}

import {
  to = module.app_backend_li_weu.azurerm_monitor_autoscale_setting.backendli[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Insights/autoScaleSettings/io-p-app-appbackendli-autoscale"
}

import {
  to = module.app_backend_li_weu.module.appservice_app_backend_slot_staging.azurerm_linux_web_app_slot.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendli/slots/staging"
}

import {
  to = module.app_backend_li_weu.module.appservice_app_backend_slot_staging.azurerm_app_service_slot_virtual_network_swift_connection.app_service_virtual_network_swift_connection[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux/providers/Microsoft.Web/sites/io-p-app-appbackendli/slots/staging/config/virtualNetwork"
}

import {
  to = module.app_backend_li_weu.module.app_backend_web_test_api.azurerm_template_deployment.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Resources/deployments/io-p-app-appbackendli.azurewebsites.net-test"
}

import {
  to = module.app_backend_li_weu.module.app_backend_web_test_api.azurerm_monitor_metric_alert.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/io-p-app-appbackendli.azurewebsites.net-test-io-p-ai-common"
}