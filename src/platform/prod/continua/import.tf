# Use this file to import the wanted resources inside the state file, 
# remember to cleanup the import code blocks with a separate PR once the import has been completed successfully.
# Here is the documentation which explains how to use the import code block: https://developer.hashicorp.com/terraform/language/block/import

import {
  to = module.continua_app_service_itn.azurerm_monitor_autoscale_setting.appservice_continua
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-continua-rg-01/providers/Microsoft.Insights/autoScaleSettings/io-p-itn-continua-app-01-autoscale"
}

import {
  to = azurerm_resource_group.continua_itn_rg
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-continua-rg-01"
}

import {
  to = module.continua_app_service_itn.module.appservice_continua_itn.azurerm_linux_web_app.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-continua-rg-01/providers/Microsoft.Web/sites/io-p-itn-continua-app-01"
}

import {
  to = module.continua_app_service_itn.module.appservice_continua_itn.azurerm_linux_web_app_slot.this[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-continua-rg-01/providers/Microsoft.Web/sites/io-p-itn-continua-app-01/slots/staging"
}

import {
  to = module.continua_app_service_itn.module.appservice_continua_itn.azurerm_private_endpoint.app_service_sites
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-continua-rg-01/providers/Microsoft.Network/privateEndpoints/io-p-itn-continua-app-pep-01"
}

import {
  to = module.continua_app_service_itn.module.appservice_continua_itn.azurerm_private_endpoint.staging_app_service_sites[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-continua-rg-01/providers/Microsoft.Network/privateEndpoints/io-p-itn-continua-staging-app-pep-01"
}

import {
  to = module.continua_app_service_itn.module.appservice_continua_itn.azurerm_service_plan.this[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-continua-rg-01/providers/Microsoft.Web/serverFarms/io-p-itn-continua-asp-01"
}

import {
  to = module.continua_app_service_itn.module.appservice_continua_itn.azurerm_subnet.this[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Network/virtualNetworks/io-p-itn-common-vnet-01/subnets/io-p-itn-continua-app-snet-01"
}