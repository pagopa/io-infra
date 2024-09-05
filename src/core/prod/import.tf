import {
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-sec-rg/providers/Microsoft.KeyVault/vaults/io-p-kv/objectId/f3b3f72f-4770-47a5-8c1e-aa298003be12"
  to = module.key_vault_weu.azurerm_key_vault_access_policy.cdn
}

import {
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-sec-rg/providers/Microsoft.KeyVault/vaults/io-p-kv/objectId/0f0aa158-b7ad-4cac-af02-82c3e4768ee6"
  to = module.key_vault_weu.azurerm_key_vault_access_policy.kv_adgroup_admin
}

import {
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-sec-rg/providers/Microsoft.KeyVault/vaults/io-p-kv/objectId/32544b2f-b97d-4453-9555-1ad71630512c"
  to = module.key_vault_weu.azurerm_key_vault_access_policy.kv_adgroup_developers
}

import {
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-sec-rg/providers/Microsoft.KeyVault/vaults/io-p-kv/objectId/8d5d04c7-98f7-4f27-91ae-249231d96918"
  to = module.key_vault_weu.azurerm_key_vault_access_policy.kv_io_infra_ci
}

import {
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-sec-rg/providers/Microsoft.KeyVault/vaults/io-p-kv/objectId/19c9e57c-3b95-4cb4-9408-f596f1cc8f8f"
  to = module.key_vault_weu.azurerm_key_vault_access_policy.kv_io_infra_cd
}

import {
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-sec-rg/providers/Microsoft.KeyVault/vaults/io-p-kv/objectId/60210551-7492-4e02-a89e-0c9eda59bfec"
  to = module.key_vault_weu.azurerm_key_vault_access_policy.kv_azdevops_platform_iac
}

# common

import {
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.KeyVault/vaults/io-p-kv-common/objectId/0f0aa158-b7ad-4cac-af02-82c3e4768ee6"
  to = module.key_vault_weu.azurerm_key_vault_access_policy.kv_common_adgroup_admin
}

import {
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.KeyVault/vaults/io-p-kv-common/objectId/32544b2f-b97d-4453-9555-1ad71630512c"
  to = module.key_vault_weu.azurerm_key_vault_access_policy.kv_common_adgroup_developers
}

import {
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.KeyVault/vaults/io-p-kv-common/objectId/8d5d04c7-98f7-4f27-91ae-249231d96918"
  to = module.key_vault_weu.azurerm_key_vault_access_policy.kv_common_io_infra_ci
}

import {
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.KeyVault/vaults/io-p-kv-common/objectId/19c9e57c-3b95-4cb4-9408-f596f1cc8f8f"
  to = module.key_vault_weu.azurerm_key_vault_access_policy.kv_common_io_infra_cd
}

import {
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.KeyVault/vaults/io-p-kv-common/objectId/bb319217-f6ab-45d9-833d-555ef1173316"
  to = module.key_vault_weu.azurerm_key_vault_access_policy.app_service
}

import {
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.KeyVault/vaults/io-p-kv-common/objectId/f3b3f72f-4770-47a5-8c1e-aa298003be12"
  to = module.key_vault_weu.azurerm_key_vault_access_policy.cdn_common
}

import {
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.KeyVault/vaults/io-p-kv-common/objectId/60210551-7492-4e02-a89e-0c9eda59bfec"
  to = module.key_vault_weu.azurerm_key_vault_access_policy.kv_common_azdevops_platform_iac
}
