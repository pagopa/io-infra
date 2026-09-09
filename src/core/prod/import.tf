# Use this file to import the wanted resources inside the state file, 
# remember to cleanup the import code blocks with a separate PR once the import has been completed successfully.
# Here is the documentation which explains how to use the import code block: https://developer.hashicorp.com/terraform/language/block/import

import {
  to = module.storage_accounts_itn.azurerm_storage_account.iopitndataexportst01["0"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-operations/providers/Microsoft.Storage/storageAccounts/iopitndataexportst01"
}

import {
  to = module.storage_accounts_itn.azurerm_storage_account.retirements_itn_01["0"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Storage/storageAccounts/iopitnretirementsst01"
}

import {
  to = module.storage_accounts_itn.module.retirements_itn_01_admins[0].module.storage_account.azurerm_role_assignment.blob["iopitnretirementsst01|*|owner|Storage Blob Data Owner"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Storage/storageAccounts/iopitnretirementsst01/providers/Microsoft.Authorization/roleAssignments/3a6bd343-0337-e08c-2e52-064de3f20d67"
}

import {
  to = module.storage_accounts_itn.module.retirements_itn_01_admins[0].module.storage_account.azurerm_role_assignment.table["iopitnretirementsst01|*|owner|Storage Table Data Contributor"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Storage/storageAccounts/iopitnretirementsst01/providers/Microsoft.Authorization/roleAssignments/c377bc26-30b8-8714-bc30-8db59dfc8088"
}

import {
  to = module.storage_accounts_weu.azurerm_storage_account.app["0"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.Storage/storageAccounts/iopstapp"
}

import {
  to = module.storage_accounts_weu.azurerm_storage_account.exportdata_weu_01["0"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-operations/providers/Microsoft.Storage/storageAccounts/iopstexportdata"
}

import {
  to = module.storage_accounts_weu.module.exportdata_weu_01_com_admins[0].module.storage_account.azurerm_role_assignment.blob["iopstexportdata|*|writer|PagoPA Storage Blob Tags Contributor"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-operations/providers/Microsoft.Storage/storageAccounts/iopstexportdata/providers/Microsoft.Authorization/roleAssignments/403456c7-c618-992d-074b-705546f07202"
}

import {
  to = module.storage_accounts_weu.module.exportdata_weu_01_com_admins[0].module.storage_account.azurerm_role_assignment.blob["iopstexportdata|*|writer|Storage Blob Data Contributor"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-operations/providers/Microsoft.Storage/storageAccounts/iopstexportdata/providers/Microsoft.Authorization/roleAssignments/e160064f-814c-668b-5677-ddc111a311ae"
}

import {
  to = module.storage_accounts_weu.module.exportdata_weu_01_com_admins[0].module.storage_account.azurerm_role_assignment.queue["iopstexportdata|*|owner|Storage Queue Data Contributor"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-operations/providers/Microsoft.Storage/storageAccounts/iopstexportdata/providers/Microsoft.Authorization/roleAssignments/2a70391f-dde3-1406-301a-9a4bd24abe28"
}

import {
  to = module.storage_accounts_weu.module.exportdata_weu_01_com_admins[0].module.storage_account.azurerm_role_assignment.table["iopstexportdata|*|writer|Storage Table Data Contributor"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-operations/providers/Microsoft.Storage/storageAccounts/iopstexportdata/providers/Microsoft.Authorization/roleAssignments/cad27d1e-c314-f777-df7f-de447e420e7b"
}

import {
  to = module.storage_accounts_weu.module.exportdata_weu_01_com_devs[0].module.storage_account.azurerm_role_assignment.blob["iopstexportdata|*|writer|PagoPA Storage Blob Tags Contributor"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-operations/providers/Microsoft.Storage/storageAccounts/iopstexportdata/providers/Microsoft.Authorization/roleAssignments/9b6366fb-19c7-9dc3-3ce6-40cc0d994507"
}

import {
  to = module.storage_accounts_weu.module.exportdata_weu_01_com_devs[0].module.storage_account.azurerm_role_assignment.blob["iopstexportdata|*|writer|Storage Blob Data Contributor"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-operations/providers/Microsoft.Storage/storageAccounts/iopstexportdata/providers/Microsoft.Authorization/roleAssignments/1f92ad3d-1ede-9731-3fcf-d040f521b7e5"
}

import {
  to = module.storage_accounts_weu.module.exportdata_weu_01_com_devs[0].module.storage_account.azurerm_role_assignment.queue["iopstexportdata|*|owner|Storage Queue Data Contributor"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-operations/providers/Microsoft.Storage/storageAccounts/iopstexportdata/providers/Microsoft.Authorization/roleAssignments/4aa0e5e7-2f2b-655a-addf-f2bd50bb080d"
}

import {
  to = module.storage_accounts_weu.module.exportdata_weu_01_com_devs[0].module.storage_account.azurerm_role_assignment.table["iopstexportdata|*|writer|Storage Table Data Contributor"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-operations/providers/Microsoft.Storage/storageAccounts/iopstexportdata/providers/Microsoft.Authorization/roleAssignments/3d1cbb9f-bee1-6dca-5fb9-b50d524f8955"
}
