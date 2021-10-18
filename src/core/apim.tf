# APIM subnet
module "apim_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                 = "apimapi"
  resource_group_name  = data.azurerm_resource_group.vnet_common_rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name
  address_prefixes     = var.cidr_subnet_apim

  enforce_private_link_endpoint_network_policies = false

  service_endpoints = [
    "Microsoft.Web",
  ]
}

locals {
  apim_hostname_api_app_internal = format("api-app.internal.%s.%s", var.dns_zone_io, var.external_domain)
  apim_hostname_api_internal     = "api-internal.io.italia.it" # todo change in format("api.internal.%s.%s", var.dns_zone_io, var.external_domain)
}

# ###########################
# ## Api Management (apim) ##
# ###########################

module "apim" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management?ref=add-apim-extension"

  subnet_id                 = module.apim_snet.id
  location                  = azurerm_resource_group.rg_internal.location
  name                      = format("%s-apim-api", local.project)
  resource_group_name       = azurerm_resource_group.rg_internal.name
  publisher_name            = var.apim_publisher_name
  publisher_email           = data.azurerm_key_vault_secret.apim_publisher_email.value
  notification_sender_email = data.azurerm_key_vault_secret.apim_publisher_email.value
  sku_name                  = var.apim_sku
  virtual_network_type      = "Internal"

  # redis_connection_string = var.apim_redis_cache_enabled ? module.apim_redis[0].primary_connection_string : null
  # redis_cache_id          = var.apim_redis_cache_enabled ? module.apim_redis[0].id : null
  redis_connection_string = null
  redis_cache_id          = null

  # This enables the Username and Password Identity Provider
  sign_up_enabled = false

  hostname_configuration = {
    proxy = [
      {
        # api-internal.io.italia.it
        default_ssl_binding = true
        host_name           = local.apim_hostname_api_internal
        key_vault_id = replace(
          data.azurerm_key_vault_certificate.api_internal_io_italia_it.secret_id,
          "/${data.azurerm_key_vault_certificate.api_internal_io_italia_it.version}",
          ""
        )
      },
      {
        # api-app.internal.io.pagopa.it
        default_ssl_binding = false
        host_name           = local.apim_hostname_api_app_internal
        key_vault_id = replace(
          data.azurerm_key_vault_certificate.api_app_internal_io_pagopa_it.secret_id,
          "/${data.azurerm_key_vault_certificate.api_app_internal_io_pagopa_it.version}",
          ""
        )
      },
    ]
    developer_portal = null
    management       = null
    portal           = null
  }

  lock_enable = false # no lock

  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  tags = var.tags
}

data "azurerm_key_vault_secret" "apim_publisher_email" {
  name         = "apim-publisher-email"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_certificate" "api_internal_io_italia_it" {
  name         = replace(local.apim_hostname_api_internal, ".", "-")
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_certificate" "api_app_internal_io_pagopa_it" {
  name         = replace(local.apim_hostname_api_app_internal, ".", "-")
  key_vault_id = module.key_vault.id
}

# ## api management key vault policy ##
resource "azurerm_key_vault_access_policy" "kv" {
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.apim.principal_id

  key_permissions         = []
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
  storage_permissions     = []
}

resource "azurerm_key_vault_access_policy" "common" {
  key_vault_id = data.azurerm_key_vault.common.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.apim.principal_id

  key_permissions         = []
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
  storage_permissions     = []
}
