data "azurerm_key_vault_secret" "assets_cdn_fn_key_cdn" {
  name         = "${var.assets_cdn_fn.name}-KEY-CDN"
  key_vault_id = var.key_vault_common.id
}

# The Azure Function serves as proxy to forward all the requests to the correct path, 
# in the case a new path has to be added, you need to alter the function configuration and re-deploy it
# the function repository is the following: https://github.com/pagopa/io-functions-assets