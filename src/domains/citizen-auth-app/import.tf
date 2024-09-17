## This file is going to be deleted as soon as it is applied
import {
  to = azurerm_private_endpoint.locked_profiles_storage_table
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.Network/privateEndpoints/ioplockedprofilesst-table-endpoint"
}

import {
  to = azurerm_storage_table.locked_profiles
  id = "https://ioplockedprofilesst.table.core.windows.net/Tables('lockedprofiles')"
}

import {
  to = module.locked_profiles_storage.azurerm_advanced_threat_protection.this[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.Storage/storageAccounts/ioplockedprofilesst/providers/Microsoft.Security/advancedThreatProtectionSettings/current"
}

import {
  to = module.locked_profiles_storage.azurerm_monitor_metric_alert.storage_account_low_availability[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.Insights/metricAlerts/[IO-AUTH | ioplockedprofilesst] Low Availability"
}

import {
  to = module.locked_profiles_storage.azurerm_storage_account.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.Storage/storageAccounts/ioplockedprofilesst"
}