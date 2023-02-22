#!/bin/bash

# bash terraform.sh import prod 'azurerm_resource_group.rg_common' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common'

# bash terraform.sh import prod 'module.key_vault_common.azurerm_key_vault.this' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.KeyVault/vaults/io-p-kv-common'

# terraform state rm 'module.key_vault.azurerm_management_lock.this[0]'
