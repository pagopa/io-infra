import {
  to = module.assets_cdn_weu.azurerm_cdn_endpoint.assets_cdn_endpoint
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-assets-cdn-rg/providers/Microsoft.Cdn/profiles/io-p-assets-cdn-profile/endpoints/io-p-assets-cdn-endpoint"
}

import {
  to = module.assets_cdn_weu.azurerm_cdn_endpoint_custom_domain.assets_cdn
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-assets-cdn-rg/providers/Microsoft.Cdn/profiles/io-p-assets-cdn-profile/endpoints/io-p-assets-cdn-endpoint/customDomains/assets-cdn-io-pagopa-it"
}

import {
  to = module.assets_cdn_weu.azurerm_cdn_endpoint_custom_domain.assets_cdn_io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-assets-cdn-rg/providers/Microsoft.Cdn/profiles/io-p-assets-cdn-profile/endpoints/io-p-assets-cdn-endpoint/customDomains/assets-cdn-io-italia-it"
}

import {
  to = module.assets_cdn_weu.azurerm_cdn_profile.assets_cdn_profile
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-assets-cdn-rg/providers/Microsoft.Cdn/profiles/io-p-assets-cdn-profile"
}

import {
  to = module.assets_cdn_weu.azurerm_dns_cname_record.assets_cdn_io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.italia.it/CNAME/assets.cdn"
}

import {
  to = module.assets_cdn_weu.azurerm_dns_cname_record.assets_cdn_io_pagopa_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.pagopa.it/CNAME/assets.cdn"
}

import {
  to = module.assets_cdn_weu.azurerm_resource_group.assets_cdn_rg
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-assets-cdn-rg"
}

import {
  to = module.assets_cdn_weu.module.assets_cdn.azurerm_monitor_metric_alert.storage_account_low_availability[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/[iopstcdnassets] Low Availability"
}

import {
  to = module.assets_cdn_weu.module.assets_cdn.azurerm_storage_account.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Storage/storageAccounts/iopstcdnassets"
}