data "azurerm_resource_group" "core_ext" {
  name = format("%s-rg-external", local.product)
}

data "azurerm_resource_group" "core_rg_common" {
  name = format("%s-rg-common", local.product)
}

data "azurerm_key_vault" "core_kv_common" {
  name                = format("%s-kv-common", local.product)
  resource_group_name = data.azurerm_resource_group.core_rg_common.name
}

data "azurerm_dns_zone" "io_italia_it" {
  name                = "io.italia.it"
  resource_group_name = data.azurerm_resource_group.core_ext.name
}

module "landing_cdn" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cdn?ref=v6.3.1"

  name                  = "landing"
  prefix                = local.project
  resource_group_name   = azurerm_resource_group.integration_rg.name
  location              = azurerm_resource_group.integration_rg.location
  hostname              = "firma.io.italia.it"
  https_rewrite_enabled = true

  # The argument `lock_enabled` is required by the module; however it must not
  # be used any more, since locks are managed transparently via global policies.
  lock_enabled = false

  index_document     = "index.html"
  error_404_document = "index.html"

  dns_zone_name                = data.azurerm_dns_zone.io_italia_it.name
  dns_zone_resource_group_name = data.azurerm_resource_group.core_ext.name

  keyvault_vault_name          = data.azurerm_key_vault.core_kv_common.name
  keyvault_resource_group_name = data.azurerm_resource_group.core_rg_common.name
  keyvault_subscription_id     = data.azurerm_subscription.current.subscription_id

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
        name   = "Content-Security-Policy-Report-Only"
        value  = "script-src 'self'; style-src 'self'; worker-src 'none'; font-src 'self'; img-src 'self'; "
      }
    ]
  }

  tags = var.tags
}
