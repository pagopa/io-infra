data "azurerm_api_management" "apim_v2_api" {
  name                = local.apim_v2_name
  resource_group_name = local.apim_resource_group_name
}

####################################################################################
# Lollipop APIM Product
####################################################################################
resource "azurerm_api_management_group" "api_lollipop_assertion_read_v2" {
  name                = "apilollipopassertionread"
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  display_name        = "ApiLollipopAssertionRead"
  description         = "A group that enables LC to retrieve user's assertion on a Lollipop flow"
}

module "apim_v2_product_lollipop" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//api_management_product?ref=v4.1.5"

  product_id   = "io-lollipop-api"
  display_name = "IO LOLLIPOP API"
  description  = "Product for IO Lollipop"

  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/io_lollipop/_base_policy.xml")
}

module "apim_v2_lollipop_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//api_management_api?ref=v4.1.5"

  name                  = format("%s-lollipop-api", local.product)
  api_management_name   = data.azurerm_api_management.apim_v2_api.name
  resource_group_name   = data.azurerm_api_management.apim_v2_api.resource_group_name
  product_ids           = [module.apim_v2_product_lollipop.product_id]
  subscription_required = true
  service_url           = null

  description  = "IO LolliPOP API"
  display_name = "IO LolliPOP API"
  path         = "lollipop/api/v1"
  protocols    = ["https"]

  content_format = "openapi"

  content_value = file("./api/io_lollipop/v1/_openapi.yaml")

  xml_content = file("./api/io_lollipop/v1/policy.xml")
}

# Named Value fn-lollipop
resource "azurerm_api_management_named_value" "io_fn_weu_lollipop_url_v2" {
  name                = "io-fn-weu-lollipop-url"
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  display_name        = "io-fn-weu-lollipop-url"
  value               = "https://io-p-weu-lollipop-fn.azurewebsites.net"
}

data "azurerm_key_vault_secret" "io_fn_weu_lollipop_key_secret_v2" {
  name         = "io-fn-weu-lollipop-KEY-APIM"
  key_vault_id = module.key_vault.id
}

resource "azurerm_api_management_named_value" "io_fn_weu_lollipop_key_v2" {
  name                = "io-fn-weu-lollipop-key"
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  display_name        = "io-fn-weu-lollipop-key"
  value               = data.azurerm_key_vault_secret.io_fn_weu_lollipop_key_secret_v2.value
  secret              = "true"
}

####################################################################################
# PagoPA General Lollipop User
####################################################################################
resource "azurerm_api_management_user" "pagopa_user_v2" {
  user_id             = "iolollipoppagopauser"
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  first_name          = "PagoPA"
  last_name           = "PagoPA"
  email               = "io-lollipop-pagopa@pagopa.it"
  state               = "active"
}

resource "azurerm_api_management_group_user" "pagopa_group_v2" {
  user_id             = azurerm_api_management_user.pagopa_user_v2.user_id
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  group_name          = azurerm_api_management_group.api_lollipop_assertion_read_v2.name
}

resource "azurerm_api_management_subscription" "pagopa_v2" {
  user_id             = azurerm_api_management_user.pagopa_user_v2.id
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  product_id          = module.apim_v2_product_lollipop.id
  display_name        = "Lollipop API"
  state               = "active"
  allow_tracing       = false
}

resource "azurerm_api_management_subscription" "pagopa_fastlogin_v2" {
  user_id             = azurerm_api_management_user.pagopa_user_v2.id
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  product_id          = module.apim_v2_product_lollipop.id
  display_name        = "Fast Login LC"
  state               = "active"
  allow_tracing       = false
}

####################################################################################
# PagoPA General Lollipop Secret
####################################################################################

resource "azurerm_key_vault_secret" "first_lollipop_consumer_subscription_key_v2" {
  name         = "first-lollipop-consumer-pagopa-subscription-key-v2"
  value        = azurerm_api_management_subscription.pagopa_v2.primary_key
  key_vault_id = module.key_vault.id
}

####################################################################################
# PagoPA Functions-fast-login Secrets
####################################################################################

# subscription key used for assertion retrieval
resource "azurerm_key_vault_secret" "fast_login_subscription_key_v2" {
  name         = "fast-login-subscription-key-v2"
  value        = azurerm_api_management_subscription.pagopa_fastlogin_v2.primary_key
  key_vault_id = module.key_vault.id
}

####################################################################################
# FIMS admin API
####################################################################################

data "azurerm_linux_web_app" "appservice_fims" {
  name                = "${local.product}-${var.domain}-${var.location_short}-${var.fims_app_instance}-app-fims"
  resource_group_name = "${local.common_project}-fims-rg"
}

module "apim_product_fims_admin" {
  source = "github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v4.1.15"

  product_id            = "fims-admin-api"
  api_management_name   = data.azurerm_api_management.apim_v2_api.name
  resource_group_name   = data.azurerm_api_management.apim_v2_api.resource_group_name
  display_name          = "FIMS ADMIN API"
  description           = "ADMIN API for FIMS openid provider."
  subscription_required = true
  approval_required     = false
  published             = true

  policy_xml = file("./api_product/fims/_base_policy.xml")
}

module "api_fims_admin" {
  source = "github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v4.1.15"

  name                = "fims-admin-api"
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  revision            = "1"
  display_name        = "FIMS ADMIN API"
  description         = "ADMIN API for FIMS."

  path        = "fims/admin"
  protocols   = ["https"]
  product_ids = [module.apim_product_fims_admin.product_id]

  service_url = format("https://%s", data.azurerm_linux_web_app.appservice_fims.default_hostname)

  subscription_required = true

  content_format = "swagger-json"
  content_value = templatefile("./api/fims/admin/_swagger.json.tpl",
    {
      host = "api-app.internal.io.pagopa.it"
    }
  )

  xml_content = file("./api/fims/admin/policy.xml")
}

####################################################################################
# FIMS public API
####################################################################################
module "apim_product_fims_public" {
  source = "github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v4.1.15"

  product_id            = "fims-public-api"
  api_management_name   = data.azurerm_api_management.apim_v2_api.name
  resource_group_name   = data.azurerm_api_management.apim_v2_api.resource_group_name
  display_name          = "FIMS PUBLIC API"
  description           = "PUBLIC API for FIMS openid provider."
  subscription_required = false
  approval_required     = false
  published             = true

  policy_xml = file("./api_product/fims/_base_policy.xml")
}

module "api_fims_public" {
  source = "github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v4.1.15"

  name                = "fims-public-api"
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  revision            = "1"
  display_name        = "FIMS PUBLIC API"
  description         = "PUBLIC API for FIMS."

  path        = "fims"
  protocols   = ["https"]
  product_ids = [module.apim_product_fims_public.product_id]

  service_url = format("https://%s", data.azurerm_linux_web_app.appservice_fims.default_hostname)

  subscription_required = false

  content_format = "swagger-json"
  content_value = templatefile("./api/fims/public/_swagger.json.tpl",
    {
      host = "api-app.internal.io.pagopa.it"
    }
  )

  xml_content = file("./api/fims/public/policy.xml")
}
