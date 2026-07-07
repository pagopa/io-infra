# Use this file to import the wanted resources inside the state file, 
# remember to cleanup the import code blocks with a separate PR once the import has been completed successfully.
# Here is the documentation which explains how to use the import code block: https://developer.hashicorp.com/terraform/language/block/import

import {
  to = module.iam_apim_itn_infra_ci.module.apim.azurerm_role_assignment.this["io-d-itn-apim-rg-01|io-d-itn-apim-01|owner"]
  id = "/subscriptions/a4e96bcd-59dc-4d66-b2f7-5547ad157c12/resourceGroups/io-d-itn-apim-rg-01/providers/Microsoft.ApiManagement/service/io-d-itn-apim-01/providers/Microsoft.Authorization/roleAssignments/cf826bba-4983-44f1-8017-0c6fd8dd7e1c"
}

import {
  to = module.iam_apim_itn_infra_cd.module.apim.azurerm_role_assignment.this["io-d-itn-apim-rg-01|io-d-itn-apim-01|owner"]
  id = "/subscriptions/a4e96bcd-59dc-4d66-b2f7-5547ad157c12/resourceGroups/io-d-itn-apim-rg-01/providers/Microsoft.ApiManagement/service/io-d-itn-apim-01/providers/Microsoft.Authorization/roleAssignments/1d4ba9ad-3bd6-4e18-972c-bf8224c3f5da"
}