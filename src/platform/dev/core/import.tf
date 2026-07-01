# Use this file to import the wanted resources inside the state file, 
# remember to cleanup the import code blocks with a separate PR once the import has been completed successfully.
# Here is the documentation which explains how to use the import code block: https://developer.hashicorp.com/terraform/language/block/import

import {
  to = azurerm_resource_group.platform
  id = "/subscriptions/a4e96bcd-59dc-4d66-b2f7-5547ad157c12/resourceGroups/io-d-itn-platform-rg-01"
}