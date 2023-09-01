# core domain external rg
data "azurerm_resource_group" "core_ext" {
  name = format("%s-rg-external", local.product)
}

data "azurerm_dns_zone" "ioapp_it" {
  name                = "ioapp.it"
  resource_group_name = data.azurerm_resource_group.core_ext.name
}

# keyvault where the TLS certificate is stored
data "azurerm_resource_group" "profile_rg" {
  name = format("%s-profile-sec-rg", local.product)
}

data "azurerm_key_vault" "profile_kv" {
  name                = format("%s-profile-kv", local.product)
  resource_group_name = data.azurerm_resource_group.profile_rg.name
}
#

module "landing_cdn" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cdn?ref=v7.2.1"

  name                  = "portal"
  prefix                = local.project
  resource_group_name   = azurerm_resource_group.fe_rg.name
  location              = azurerm_resource_group.fe_rg.location
  hostname              = "ioapp.it"
  https_rewrite_enabled = true

  index_document     = "index.html"
  error_404_document = "it/404.html"

  dns_zone_name                = data.azurerm_dns_zone.ioapp_it.name
  dns_zone_resource_group_name = data.azurerm_resource_group.core_ext.name

  keyvault_vault_name          = data.azurerm_key_vault.profile_kv.name
  keyvault_resource_group_name = data.azurerm_resource_group.profile_rg.name
  keyvault_subscription_id     = data.azurerm_subscription.current.id

  querystring_caching_behaviour = "BypassCaching"

  global_delivery_rule = {
    cache_expiration_action       = []
    cache_key_query_string_action = []
    modify_request_header_action  = []

    # HSTS
    modify_response_header_action = [
      {
        action = "Overwrite"
        name   = "Strict-Transport-Security"
        value  = "max-age=31536000"
      },
      # Content-Security-Policy (in Report mode)
      {
        action = "Append"
        name   = "Content-Security-Policy"
        value  = "script-src 'self' 'unsafe-inline'; worker-src 'none'; font-src data: 'self'; object-src 'none'; "
      }
    ]
  }

  tags = var.tags
}
