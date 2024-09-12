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
