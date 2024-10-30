data "azurerm_api_management" "apim_itn_api" {
  name                = local.apim_itn_name
  resource_group_name = local.apim_itn_resource_group_name
}

####################################################################################
# Lollipop APIM Product
####################################################################################
resource "azurerm_api_management_group" "api_lollipop_assertion_read_itn" {
  name                = "apilollipopassertionread"
  api_management_name = data.azurerm_api_management.apim_itn_api.name
  resource_group_name = data.azurerm_api_management.apim_itn_api.resource_group_name
  display_name        = "ApiLollipopAssertionRead"
  description         = "A group that enables LC to retrieve user's assertion on a Lollipop flow"
}

module "apim_itn_product_lollipop" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//api_management_product?ref=v8.44.1"

  product_id   = "io-lollipop-api"
  display_name = "IO LOLLIPOP API"
  description  = "Product for IO Lollipop"

  api_management_name = data.azurerm_api_management.apim_itn_api.name
  resource_group_name = data.azurerm_api_management.apim_itn_api.resource_group_name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/io_lollipop/_base_policy.xml")
}

module "apim_itn_lollipop_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//api_management_api?ref=v8.44.1"

  name                  = format("%s-lollipop-api", local.product)
  api_management_name   = data.azurerm_api_management.apim_itn_api.name
  resource_group_name   = data.azurerm_api_management.apim_itn_api.resource_group_name
  product_ids           = [module.apim_itn_product_lollipop.product_id]
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
resource "azurerm_api_management_named_value" "io_fn_itn_lollipop_url_itn" {
  name                = "io-fn-itn-lollipop-url"
  api_management_name = data.azurerm_api_management.apim_itn_api.name
  resource_group_name = data.azurerm_api_management.apim_itn_api.resource_group_name
  display_name        = "io-fn-itn-lollipop-url"
  value               = "https://${data.azurerm_linux_function_app.lollipop_function.default_hostname}"
}

data "azurerm_key_vault_secret" "io_fn_itn_lollipop_key_secret_itn" {
  name         = "io-fn-itn-lollipop-KEY-APIM"
  key_vault_id = module.key_vault.id
}

resource "azurerm_api_management_named_value" "io_fn_itn_lollipop_key_itn" {
  name                = "io-fn-itn-lollipop-key"
  api_management_name = data.azurerm_api_management.apim_itn_api.name
  resource_group_name = data.azurerm_api_management.apim_itn_api.resource_group_name
  display_name        = "io-fn-itn-lollipop-key"
  value               = data.azurerm_key_vault_secret.io_fn_itn_lollipop_key_secret_itn.value
  secret              = "true"
}

####################################################################################
# PagoPA General Lollipop User
####################################################################################
resource "azurerm_api_management_user" "pagopa_user_itn" {
  user_id             = "iolollipoppagopauser"
  api_management_name = data.azurerm_api_management.apim_itn_api.name
  resource_group_name = data.azurerm_api_management.apim_itn_api.resource_group_name
  first_name          = "PagoPA"
  last_name           = "PagoPA"
  email               = "io-lollipop-pagopa@pagopa.it"
  state               = "active"
}

resource "azurerm_api_management_group_user" "pagopa_group_itn" {
  user_id             = azurerm_api_management_user.pagopa_user_itn.user_id
  api_management_name = data.azurerm_api_management.apim_itn_api.name
  resource_group_name = data.azurerm_api_management.apim_itn_api.resource_group_name
  group_name          = azurerm_api_management_group.api_lollipop_assertion_read_itn.name
}

resource "azurerm_api_management_subscription" "pagopa_itn" {
  user_id             = azurerm_api_management_user.pagopa_user_itn.id
  api_management_name = data.azurerm_api_management.apim_itn_api.name
  resource_group_name = data.azurerm_api_management.apim_itn_api.resource_group_name
  product_id          = module.apim_itn_product_lollipop.id
  display_name        = "Lollipop API"
  state               = "active"
  allow_tracing       = false
}

resource "azurerm_api_management_subscription" "pagopa_fastlogin_itn" {
  user_id             = azurerm_api_management_user.pagopa_user_itn.id
  api_management_name = data.azurerm_api_management.apim_itn_api.name
  resource_group_name = data.azurerm_api_management.apim_itn_api.resource_group_name
  product_id          = module.apim_itn_product_lollipop.id
  display_name        = "Fast Login LC"
  state               = "active"
  allow_tracing       = false
}

####################################################################################
# PagoPA General Lollipop Secret
####################################################################################

resource "azurerm_key_vault_secret" "first_lollipop_consumer_subscription_key_itn" {
  name         = "first-lollipop-consumer-pagopa-subscription-key-itn"
  value        = azurerm_api_management_subscription.pagopa_itn.primary_key
  key_vault_id = module.key_vault.id
}

####################################################################################
# PagoPA Functions-fast-login Secrets
####################################################################################

# subscription key used for assertion retrieval
resource "azurerm_key_vault_secret" "fast_login_subscription_key_itn" {
  name         = "fast-login-subscription-key-itn"
  value        = azurerm_api_management_subscription.pagopa_fastlogin_itn.primary_key
  key_vault_id = module.key_vault.id
}

####################################################################################
# Fast-Login Operation's API
####################################################################################
resource "azurerm_api_management_group" "api_fast_login_operation_itn" {
  name                = "apifastloginoperationwrite"
  api_management_name = data.azurerm_api_management.apim_itn_api.name
  resource_group_name = data.azurerm_api_management.apim_itn_api.resource_group_name
  display_name        = "ApiFastLoginOperationWrite"
  description         = "A group that enables PagoPa Operation to operate over session lock/unlock"
}

module "apim_itn_product_fast_login_operation" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//api_management_product?ref=v8.44.1"

  product_id   = "io-fast-login-operation-api"
  display_name = "IO FAST-LOGIN OPERATION API"
  description  = "Product for IO Fast Login Operation"

  api_management_name = data.azurerm_api_management.apim_itn_api.name
  resource_group_name = data.azurerm_api_management.apim_itn_api.resource_group_name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/fast_login_operation/_base_policy.xml")
}

data "azurerm_linux_function_app" "functions_fast_login" {
  name                = local.fn_fast_login_name
  resource_group_name = local.fn_fast_login_resource_group_name
}

module "apim_itn_fast_login_operation_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//api_management_api?ref=v8.44.1"

  name                  = format("%s-fast-login-operation-api", local.product)
  api_management_name   = data.azurerm_api_management.apim_itn_api.name
  resource_group_name   = data.azurerm_api_management.apim_itn_api.resource_group_name
  product_ids           = [module.apim_itn_product_fast_login_operation.product_id]
  subscription_required = true
  service_url           = format(local.fast_login_backend_url, data.azurerm_linux_function_app.functions_fast_login.default_hostname)

  description  = "IO FAST-LOGIN OPERATION API"
  display_name = "IO Fast-Login Operation API"
  path         = "fast-login/api/v1"
  protocols    = ["https"]

  content_format = "openapi"

  content_value = file("./api/fast_login/v1/_openapi.yaml")

  xml_content = file("./api/fast_login/v1/policy.xml")
}

resource "azurerm_api_management_api_operation_policy" "lock_user_session_for_operation" {
  api_name            = format("%s-fast-login-operation-api", local.product)
  api_management_name = data.azurerm_api_management.apim_itn_api.name
  resource_group_name = data.azurerm_api_management.apim_itn_api.resource_group_name
  operation_id        = "lockUserSession"

  xml_content = file("./api/fast_login/v1/post_lockusersession_policy/policy.xml")
}

resource "azurerm_api_management_user" "fast_login_operation_user_itn" {
  user_id             = "fastloginoperationuser"
  api_management_name = data.azurerm_api_management.apim_itn_api.name
  resource_group_name = data.azurerm_api_management.apim_itn_api.resource_group_name
  first_name          = "PagoPA Operation"
  last_name           = "PagoPA Operation"
  email               = "area-assistenza-operations@pagopa.it"
  state               = "active"
}

resource "azurerm_api_management_group_user" "pagopa_operation_group_itn" {
  user_id             = azurerm_api_management_user.fast_login_operation_user_itn.user_id
  api_management_name = data.azurerm_api_management.apim_itn_api.name
  resource_group_name = data.azurerm_api_management.apim_itn_api.resource_group_name
  group_name          = azurerm_api_management_group.api_fast_login_operation_itn.name
}

resource "azurerm_api_management_subscription" "pagopa_operation_itn" {
  user_id             = azurerm_api_management_user.fast_login_operation_user_itn.id
  api_management_name = data.azurerm_api_management.apim_itn_api.name
  resource_group_name = data.azurerm_api_management.apim_itn_api.resource_group_name
  product_id          = module.apim_itn_product_fast_login_operation.id
  display_name        = "Fast Login Operation API"
  state               = "active"
  allow_tracing       = false
}



# Named Value fn-fast-login
data "azurerm_key_vault_secret" "functions_fast_login_api_key" {
  name         = "io-fn-weu-fast-login-KEY-APIM"
  key_vault_id = module.key_vault.id
}

resource "azurerm_api_management_named_value" "io_fn_itn_fast_login_operation_key_itn" {
  name                = "io-fn-itn-fast-login-operation-key"
  api_management_name = data.azurerm_api_management.apim_itn_api.name
  resource_group_name = data.azurerm_api_management.apim_itn_api.resource_group_name
  display_name        = "io-fn-itn-fast-login-operation-key"
  value               = data.azurerm_key_vault_secret.functions_fast_login_api_key.value
  secret              = "true"
}

resource "azurerm_api_management_named_value" "api_fast_login_operation_group_name" {
  name                = "api-fast-login-operation-group-name"
  api_management_name = data.azurerm_api_management.apim_itn_api.name
  resource_group_name = data.azurerm_api_management.apim_itn_api.resource_group_name
  display_name        = "api-fast-login-operation-group-name"
  value               = azurerm_api_management_group.api_fast_login_operation_itn.display_name
  secret              = "false"
}

####################################################################################
# PagoPA General PN APIM User
####################################################################################
resource "azurerm_api_management_user" "pn_user_itn" {
  user_id             = "pnapimuser"
  api_management_name = data.azurerm_api_management.apim_itn_api.name
  resource_group_name = data.azurerm_api_management.apim_itn_api.resource_group_name
  first_name          = "PNAPIMuser"
  last_name           = "PNAPIMuser"
  email               = "pn-apim-user@pagopa.it"
  state               = "active"
}

resource "azurerm_api_management_group_user" "pagopa_group_itn" {
  user_id             = azurerm_api_management_user.pn_user_itn.user_id
  api_management_name = data.azurerm_api_management.apim_itn_api.name
  resource_group_name = data.azurerm_api_management.apim_itn_api.resource_group_name
  group_name          = azurerm_api_management_group.api_lollipop_assertion_read_itn.name
}

resource "azurerm_api_management_subscription" "pn_lc_subscription_itn" {
  user_id             = azurerm_api_management_user.pn_user_itn.id
  api_management_name = data.azurerm_api_management.apim_itn_api.name
  resource_group_name = data.azurerm_api_management.apim_itn_api.resource_group_name
  product_id          = module.apim_itn_product_lollipop.product_id
  display_name        = "PN LC"
  state               = "active"
  allow_tracing       = false
}
