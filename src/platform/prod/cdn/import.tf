# Use this file to import the wanted resources inside the state file, 
# remember to cleanup the import code blocks with a separate PR once the import has been completed successfully.
# Here is the documentation which explains how to use the import code block: https://developer.hashicorp.com/terraform/language/block/import

import {
  to = module.legacy_assets_cdn_storage_account.azurerm_monitor_metric_alert.storage_account_low_availability[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/[iopstcdnassets] Low Availability"
}

import {
  to = module.legacy_assets_cdn_storage_account.azurerm_storage_account.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Storage/storageAccounts/iopstcdnassets"
}

import {
  to = module.legacy_cdn_svc_devs.module.storage_account.azurerm_role_assignment.blob["iopstcdnassets|*|writer|PagoPA Storage Blob Tags Contributor"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Storage/storageAccounts/iopstcdnassets/providers/Microsoft.Authorization/roleAssignments/404ad6f0-a28b-0fd9-c529-634707e7b8c5"
}

import {
  to = module.legacy_cdn_svc_devs.module.storage_account.azurerm_role_assignment.blob["iopstcdnassets|*|writer|Storage Blob Data Contributor"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Storage/storageAccounts/iopstcdnassets/providers/Microsoft.Authorization/roleAssignments/9f86a968-a043-b5d7-9b85-59b77e54988d"
}