/**
 * selfcare resource group
 **/
resource "azurerm_resource_group" "selfcare_fe_rg" {
  name     = "${local.project}-selfcare-fe-rg"
  location = var.location

  tags = var.tags
}

/**
 * CDN
 */
// public storage used to serve FE
#tfsec:ignore:azure-storage-default-action-deny
module "selfcare_cdn" {
  source = "git::https://github.com/pagopa/azurerm.git//cdn?ref=v2.0.2"

  name                  = "selfcare"
  prefix                = local.project
  resource_group_name   = azurerm_resource_group.selfcare_fe_rg.name
  location              = var.location
  hostname              = "${var.dns_zone_io}.${var.external_domain}"
  https_rewrite_enabled = true
  lock_enabled          = var.lock_enable

  index_document     = "index.html"
  error_404_document = "404.html"

  dns_zone_name                = azurerm_dns_zone.io_pagopa_it[0].name
  dns_zone_resource_group_name = azurerm_dns_zone.io_pagopa_it[0].resource_group_name

  keyvault_resource_group_name = module.key_vault.resource_group_name
  keyvault_subscription_id     = data.azurerm_subscription.current.subscription_id
  keyvault_vault_name          = module.key_vault.name

  querystring_caching_behaviour = "BypassCaching"

  global_delivery_rule = {
    cache_expiration_action       = []
    cache_key_query_string_action = []
    modify_request_header_action  = []

    # HSTS
    modify_response_header_action = [{
      action = "Overwrite"
      name   = "Strict-Transport-Security"
      value  = "max-age=31536000"
      },
      # Content-Security-Policy (in Report mode)
      {
        action = "Append"
        name   = "Content-Security-Policy-Report-Only"
        value  = "script-src 'self' https://www.google.com https://www.gstatic.com; style-src 'self' 'unsafe-inline' https://fonts.googleapis.com; worker-src 'none'; font-src 'self' https://fonts.googleapis.com https://fonts.gstatic.com; "
      },
      {
        action = "Append"
        name   = "Content-Security-Policy-Report-Only"
        value  = "img-src 'self' https://assets.cdn.io.italia.it data:; "
      }
    ]
  }

  tags = var.tags
}

# #tfsec:ignore:AZU023
# resource "azurerm_key_vault_secret" "selc_web_storage_access_key" {
#   name         = "web-storage-access-key"
#   value        = module.selfcare_cdn.storage_primary_access_key
#   content_type = "text/plain"

#   key_vault_id = module.key_vault.id
# }

# resource "azurerm_key_vault_secret" "selc_web_storage_connection_string" {
#   name         = "web-storage-connection-string"
#   value        = module.selfcare_cdn.storage_primary_connection_string
#   content_type = "text/plain"

#   key_vault_id = module.key_vault.id
# }

# resource "azurerm_key_vault_secret" "selc_web_storage_blob_connection_string" {
#   name         = "web-storage-blob-connection-string"
#   value        = module.selfcare_cdn.storage_primary_blob_connection_string
#   content_type = "text/plain"

#   key_vault_id = module.key_vault.id
# }
