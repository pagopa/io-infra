# Use this file to import the wanted resources inside the state file, 
# remember to cleanup the import code blocks with a separate PR once the import has been completed successfully.
# Here is the documentation which explains how to use the import code block: https://developer.hashicorp.com/terraform/language/block/import

import {
  to = azurerm_key_vault_secret.cosmos_api_connection_string
  id = "https://io-p-kv-common.vault.azure.net/secrets/cosmos-api-connection-string/1e80c3c718264c78a975cd89c610e935"
}

import {
  to = azurerm_key_vault_secret.cosmos_api_primary_key
  id = "https://io-p-kv-common.vault.azure.net/secrets/cosmos-api-primary-key/249d513be5a14f6aba09eb9c8f48c488"
}