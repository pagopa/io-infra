# Use this file to import the wanted resources inside the state file, 
# remember to cleanup the import code blocks with a separate PR once the import has been completed successfully.
# Here is the documentation which explains how to use the import code block: https://developer.hashicorp.com/terraform/language/block/import

import {
  to = module.key_vault_weu.azurerm_key_vault_access_policy.kv_common_ci["8e33ccf6-17bd-4960-a2de-e5015c06f5f6"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.KeyVault/vaults/io-p-kv-common/objectId/8e33ccf6-17bd-4960-a2de-e5015c06f5f6"
}

import {
  to = module.key_vault_weu.azurerm_key_vault_access_policy.kv_common_cd["98af3cfc-b866-4172-80eb-aa11c5769d8f"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.KeyVault/vaults/io-p-kv-common/objectId/98af3cfc-b866-4172-80eb-aa11c5769d8f"
}