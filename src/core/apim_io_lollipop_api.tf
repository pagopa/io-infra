resource "azurerm_api_management_group" "apilollipopassertionread" {
  name                = "apilollipopassertionread"
  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name
  display_name        = "ApiLollipopAssertionRead"
  description         = "A group that enables LC to retrieve user's assertion on a Lollipop flow"
}

module "apim_product_lollipop" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//api_management_product?ref=v4.1.5"

  product_id   = "io-lollipop-api"
  display_name = "IO LOLLIPOP API"
  description  = "Product for IO Lollipop"

  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/io_lollipop/_base_policy.xml")
}

module "apim_lollipop_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//api_management_api?ref=v4.1.5"

  name                  = format("%s-lollipop-api", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = module.apim.resource_group_name
  product_ids           = [module.apim_product_lollipop.product_id]
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
resource "azurerm_api_management_named_value" "io_fn_lollipop_url" {
  name                = "io-fn-lollipop-url"
  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name
  display_name        = "io-fn-lollipop-url"
  value               = "https://io-p-lollipop-fn.azurewebsites.net"
}

data "azurerm_key_vault_secret" "io_fn_lollipop_key_secret" {
  name         = "fn-lollipop-KEY-APIM"
  key_vault_id = data.azurerm_key_vault.common.id
}

resource "azurerm_api_management_named_value" "io_fn_lollipop_key" {
  name                = "io-fn-lollipop-key"
  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name
  display_name        = "io-fn-lollipop-key"
  value               = data.azurerm_key_vault_secret.io_fn_lollipop_key_secret.value
  secret              = "true"
}

####################################################################################
# PagoPA General Lollipop User
####################################################################################
resource "azurerm_api_management_user" "pagopa_user" {
  user_id             = "iolollipoppagopauser"
  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name
  first_name          = "PagoPA"
  last_name           = "PagoPA"
  email               = "io-lollipop-pagopa@pagopa.it"
  state               = "active"
}

resource "azurerm_api_management_group_user" "pagopa_group" {
  user_id             = azurerm_api_management_user.pagopa_user.user_id
  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name
  group_name          = azurerm_api_management_group.apilollipopassertionread.name
}

resource "azurerm_api_management_subscription" "pagopa" {
  user_id             = azurerm_api_management_user.pagopa_user.id
  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name
  product_id          = module.apim_product_lollipop.id
  display_name        = "Lollipop API"
  state               = "active"
}
####################################################################################
