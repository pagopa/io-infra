# Use this file to import the wanted resources inside the state file, 
# remember to cleanup the import code blocks with a separate PR once the import has been completed successfully.
# Here is the documentation which explains how to use the import code block: https://developer.hashicorp.com/terraform/language/block/import

import {
  to = azurerm_resource_group.github_runner_itn
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-github-runner-rg-01"
}

import {
  to = module.github_runner_itn.azurerm_container_app_environment.github_runner
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-github-runner-rg-01/providers/Microsoft.App/managedEnvironments/io-p-itn-github-runner-cae-01"
}

import {
  to = module.github_runner_itn.azurerm_subnet.github_runner
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Network/virtualNetworks/io-p-itn-common-vnet-01/subnets/io-p-itn-github-runner-snet-01"
}

import {
  to = module.github_runner_itn.module.container_app_github_runner.azurerm_container_app_job.github_runner
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-github-runner-rg-01/providers/Microsoft.App/jobs/io-p-itn-io-infra-caj-01"
}

import {
  to = module.github_runner_itn.module.container_app_github_runner.azurerm_key_vault_access_policy.keyvault_containerapp[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.KeyVault/vaults/io-p-kv-common/objectId/1d054958-068f-42ce-b52f-78ac2bd70574"
}