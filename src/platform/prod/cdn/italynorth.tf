module "ioapp" {
  source                         = "./_modules/ioapp"
  location                       = local.location_short.italynorth
  storage_account_location       = local.location.westeurope
  resource_group_cdn             = local.core.resource_groups.italynorth.common
  storage_account_resource_group = local.resource_groups.weu.ioweb
  log_analytics_workspace_id     = local.common.monitoring.itn.law_id
  tags                           = local.tags
}

/*
import {
  to = module.ioapp.module.ioapp.azurerm_dns_a_record.this["ioapp.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/ioapp.it/A/@"
}

import {
  to = module.ioapp.module.ioapp.azurerm_dns_txt_record.validation["ioapp.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/ioapp.it/TXT/_dnsauth"
}
*/