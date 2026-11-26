# Use this file to import the wanted resources inside the state file, 
# remember to cleanup the import code blocks with a separate PR once the import has been completed successfully.
# Here is the documentation which explains how to use the import code block: https://developer.hashicorp.com/terraform/language/block/import

import {
  to = module.assets_locales.module.cdn_storage.azurerm_storage_account_static_website.this[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Storage/storageAccounts/iopitnassetsst01"
}

import {
  to = azurerm_storage_account_static_website.legacy_assets_cdn_storage_account
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Storage/storageAccounts/iopstcdnassets"
}
