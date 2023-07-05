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
}

resource "azurerm_api_management_subscription" "pagopa_fastlogin_v2" {
  user_id             = azurerm_api_management_user.pagopa_user_v2.id
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  product_id          = module.apim_v2_product_lollipop.id
  display_name        = "Fast Login LC"
  state               = "active"
}

####################################################################################
# PagoPA General Lollipop Secret
####################################################################################
resource "azurerm_key_vault_secret" "first_lollipop_consumer_subscription_key_v2" {
  name         = "first-lollipop-consumer-pagopa-subscription-key"
  value        = azurerm_api_management_subscription.pagopa_v2.primary_key
  key_vault_id = module.key_vault.id
}

####################################################################################
# PagoPA Functions-fast-login Secrets
####################################################################################

# subscription key used for assertion retrieval
resource "azurerm_key_vault_secret" "fast_login_subscription_key_v2" {
  name         = "fast-login-subscription-key"
  value        = azurerm_api_management_subscription.pagopa_fastlogin_v2.primary_key
  key_vault_id = module.key_vault.id
}