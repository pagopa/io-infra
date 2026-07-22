# Use this file to import the wanted resources inside the state file, 
# remember to cleanup the import code blocks with a separate PR once the import has been completed successfully.
# Here is the documentation which explains how to use the import code block: https://developer.hashicorp.com/terraform/language/block/import

# APIM IAM

import {
  to = azurerm_role_assignment.apim_client_role["Reader"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-apim-01/providers/Microsoft.Authorization/roleAssignments/a59f2e3d-0014-3078-3cc4-7c1ab47eb8f4"
}

import {
  to = azurerm_role_assignment.apim_client_role["API Management Service Reader Role"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-apim-01/providers/Microsoft.Authorization/roleAssignments/25d255dc-30ab-4f20-fe95-8723761a4f3f"
}

import {
  to = azurerm_role_assignment.apim_client_role["Contributor"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-apim-01/providers/Microsoft.Authorization/roleAssignments/bb2b27b7-4388-de4f-7558-17ca26d44677"
}

import {
  to = azurerm_role_assignment.dev_portal_role["Reader"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-apim-01/providers/Microsoft.Authorization/roleAssignments/780e9e7f-541a-4c18-67e1-593d5b66e3fd"
}

import {
  to = azurerm_role_assignment.dev_portal_role["API Management Service Reader Role"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-apim-01/providers/Microsoft.Authorization/roleAssignments/e33c82aa-a3ff-618d-d122-b10e5f97bb6c"
}

import {
  to = azurerm_role_assignment.dev_portal_role["Contributor"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-apim-01/providers/Microsoft.Authorization/roleAssignments/a7ae30ff-8ad1-9233-bcea-319dfbf9a2fb"
}