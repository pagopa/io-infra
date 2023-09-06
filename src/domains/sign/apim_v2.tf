data "azurerm_api_management" "apim_v2_api" {
  name                = "io-p-apim-v2-api"
  resource_group_name = "io-p-rg-internal"
}

resource "azurerm_api_management_named_value" "io_fn_sign_issuer_url_v2" {
  name                = "io-fn-sign-issuer-url"
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  display_name        = "io-fn-sign-issuer-url"
  value               = format("https://%s-sign-issuer-func.azurewebsites.net", local.product)
}

resource "azurerm_api_management_named_value" "io_fn_sign_issuer_key_v2" {
  name                = "io-fn-sign-issuer-key"
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  display_name        = "io-fn-sign-issuer-key"
  value               = module.key_vault_secrets.values["io-fn-sign-issuer-key"].value
  secret              = true
}

resource "azurerm_api_management_named_value" "io_fn_sign_support_url_v2" {
  name                = "io-fn-sign-support-url"
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  display_name        = "io-fn-sign-support-url"
  value               = format("https://%s-sign-support-func.azurewebsites.net", local.product)
}

resource "azurerm_api_management_named_value" "io_fn_sign_support_key_v2" {
  name                = "io-fn-sign-support-key"
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  display_name        = "io-fn-sign-support-key"
  value               = module.key_vault_secrets.values["io-fn-sign-support-key"].value
  secret              = true
}


resource "azurerm_api_management_named_value" "io_sign_cosmosdb_name_v2" {
  name                = "io-sign-cosmosdb-name"
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  display_name        = "io-sign-cosmosdb-name"
  value               = module.cosmosdb_account.name
  secret              = false
}

resource "azurerm_api_management_named_value" "io_sign_cosmosdb_key_v2" {
  name                = "io-sign-cosmosdb-key"
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  display_name        = "io-sign-cosmosdb-key"
  value               = module.cosmosdb_account.primary_readonly_key
  secret              = true
}

resource "azurerm_api_management_named_value" "io_sign_cosmosdb_issuer_container_name_v2" {
  name                = "io-sign-cosmosdb-issuer-container-name"
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  display_name        = "io-sign-cosmosdb-issuer-container-name"
  value               = module.cosmosdb_sql_database_issuer.name
  secret              = false
}

resource "azurerm_api_management_named_value" "io_sign_cosmosdb_issuer_whitelist_collection_name_new_v2" {
  name                = "io-sign-cosmosdb-issuer-whitelist-collection-name"
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  display_name        = "io-sign-cosmosdb-issuer-whitelist-collection-name"
  value               = module.cosmosdb_sql_container_issuer-issuers-whitelist.name
  secret              = false
}

resource "azurerm_api_management_named_value" "io_sign_cosmosdb_issuer_issuers_collection_name_v2" {
  name                = "io-sign-cosmosdb-issuer-issuers-name"
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  display_name        = "io-sign-cosmosdb-issuer-issuers-name"
  value               = module.cosmosdb_sql_container_issuer-issuers.name
  secret              = false
}


module "apim_v2_io_sign_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.20.2"

  product_id   = "io-sign-api"
  display_name = "IO SIGN API"
  description  = "Product for IO sign"

  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/sign/_base_policy.xml")
}

resource "azurerm_api_management_api_operation_policy" "get_signer_by_fiscal_code_policy_v2" {
  api_name            = module.apim_v2_io_sign_issuer_api_v1.name
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  operation_id        = "getSignerByFiscalCode"

  xml_content = file("./api/issuer/v1/get_signer_by_fiscal_code_policy/policy.xml")
}

module "apim_v2_io_sign_issuer_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.20.2"

  name                  = format("%s-sign-issuer-api", local.product)
  api_management_name   = data.azurerm_api_management.apim_v2_api.name
  resource_group_name   = data.azurerm_api_management.apim_v2_api.resource_group_name
  product_ids           = [module.apim_v2_io_sign_product.product_id]
  subscription_required = true
  service_url           = null

  description  = "IO Sign - Issuer API"
  display_name = "IO Sign - Issuer API"
  path         = "api/v1/sign"
  protocols    = ["https"]

  content_format = "openapi"

  content_value = file("./api/issuer/v1/openapi.yaml")

  xml_content = file("./api/issuer/v1/base_policy.xml")
}

module "apim_v2_io_sign_support_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.20.2"

  product_id   = "io-sign-support-api"
  display_name = "IO SIGN SUPPORT Product"
  description  = "Support Product for IO SIGN"

  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/support/_base_policy.xml")
}

module "apim_v2_io_sign_support_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.20.2"

  name                  = format("%s-sign-support-api", local.product)
  api_management_name   = data.azurerm_api_management.apim_v2_api.name
  resource_group_name   = data.azurerm_api_management.apim_v2_api.resource_group_name
  product_ids           = [module.apim_v2_io_sign_support_product.product_id]
  subscription_required = true
  service_url           = null

  description  = "IO Sign - Support API"
  display_name = "IO Sign - Support API"
  path         = "api/v1/sign/support"
  protocols    = ["https"]

  content_format = "openapi"

  content_value = file("./api/support/v1/openapi.yaml")

  xml_content = file("./api/support/v1/base_policy.xml")
}

# BACK OFFICE

resource "azurerm_api_management_named_value" "io_fn_sign_backoffice_url_v2" {
  name                = "io-fn-sign-backoffice-url"
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  display_name        = "io-fn-sign-backoffice-url"
  value               = format("https://%s-sign-backoffice-app.azurewebsites.net", local.product)
}

resource "azurerm_api_management_named_value" "io_fn_sign_backoffice_key_v2" {
  name                = "io-fn-sign-backoffice-key"
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  display_name        = "io-fn-sign-backoffice-key"
  value               = module.key_vault_secrets.values["io-fn-sign-support-key"].value
  secret              = true
}

module "apim_v2_io_sign_backoffice_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.20.2"

  product_id   = format("%s-sign-backoffice-apim-product", local.product)
  display_name = "(IO Sign) Backoffice"
  description  = "Api Management product for io-sign-backoffice REST APIs"

  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/backoffice/_base_policy.xml")
}

module "apim_v2_io_sign_backoffice_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.20.2"

  name                  = format("%s-sign-backoffice-apim-api", local.product)
  api_management_name   = data.azurerm_api_management.apim_v2_api.name
  resource_group_name   = data.azurerm_api_management.apim_v2_api.resource_group_name
  product_ids           = [module.apim_v2_io_sign_backoffice_product.product_id]
  subscription_required = true
  service_url           = null

  display_name = "(IO Sign) Backoffice API"
  description  = "io-sign-backoffice REST APIs"

  path      = "api/v1/sign/backoffice"
  protocols = ["https"]

  content_format = "openapi"

  content_value = file("./api/backoffice/v1/openapi.yaml")
  xml_content   = file("./api/backoffice/v1/base_policy.xml")
}