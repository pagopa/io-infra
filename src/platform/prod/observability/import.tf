# Use this file to import the wanted resources inside the state file, 
# remember to cleanup the import code blocks with a separate PR once the import has been completed successfully.
# Here is the documentation which explains how to use the import code block: https://developer.hashicorp.com/terraform/language/block/import

import {
  to = module.storage_accounts_westeurope.azurerm_storage_account.logs[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-operations/providers/Microsoft.Storage/storageAccounts/iopstlogs"
}

import {
  to = module.storage_accounts_italynorth.azurerm_storage_account.iopitnlogst01[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-operations/providers/Microsoft.Storage/storageAccounts/iopitnlogst01"
}

import {
  to = module.storage_accounts_italynorth.azurerm_storage_encryption_scope.iopitnlogst01[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-operations/providers/Microsoft.Storage/storageAccounts/iopitnlogst01/encryptionScopes/logsencryption"
}

import {
  to = module.storage_accounts_italynorth.azurerm_storage_management_policy.iopitnlogst01[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-operations/providers/Microsoft.Storage/storageAccounts/iopitnlogst01/managementPolicies/default"
}

import {
  to = azurerm_key_vault_secret.st_logs_primary_connection_string
  id = "https://io-p-kv-common.vault.azure.net/secrets/st-logs-primary-connection-string/c9e3fb96fec14647b17f79d4e258fbce"
}
