########
# APIM #
########

# APIM in WEU
data "azurerm_api_management" "apim_v2_api" {
  name                = local.apim_v2_name
  resource_group_name = local.apim_resource_group_name
}

# APIM in ITN
data "azurerm_api_management" "apim_itn_api" {
  name                = local.apim_itn_name
  resource_group_name = local.apim_itn_resource_group_name
}

# For subscription payment_updater_reminder_v2

data "azurerm_api_management_product" "payment_updater_product_v2" {
  product_id          = "io-payments-api"
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
}

data "azurerm_api_management_product" "payment_updater_product_itn" {
  product_id          = "io-payments-api"
  api_management_name = data.azurerm_api_management.apim_itn_api.name
  resource_group_name = data.azurerm_api_management.apim_itn_api.resource_group_name
}

# For named value io_p_messages_sending_func_key
data "azurerm_key_vault_secret" "io_p_messages_sending_func_key" {
  name         = "io-p-messages-sending-func-key"
  key_vault_id = module.key_vault.id
}

# For APIM API module apim_v2_messages_sending_external_api_v1
data "azurerm_api_management_product" "apim_v2_product_services" {
  product_id          = "io-services-api"
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
}

data "azurerm_api_management_product" "apim_itn_product_services" {
  product_id          = "io-services-api"
  api_management_name = data.azurerm_api_management.apim_itn_api.name
  resource_group_name = data.azurerm_api_management.apim_itn_api.resource_group_name
}

data "http" "messages_sending_external_openapi" {
  url = "https://raw.githubusercontent.com/pagopa/io-functions-services-messages/master/openapi/index_external.yaml"
}

# For APIM API module apim_v2_messages_sending_internal_api_v1
data "http" "messages_sending_internal_openapi" {
  url = "https://raw.githubusercontent.com/pagopa/io-functions-services-messages/master/openapi/index.yaml"
}

# For APIM API module apim_v2_service_messages_manage_api_v1
data "http" "service_messages_manage_openapi" {
  url = "https://raw.githubusercontent.com/pagopa/io-functions-services-messages/833616dceab72bd65c4d3875c64eb75787b19258/openapi/index_external.yaml"
}

# For APIM API module apim_v2_service_messages_internal_api_v1
data "http" "service_messages_internal_openapi" {
  url = "https://raw.githubusercontent.com/pagopa/io-functions-services-messages/833616dceab72bd65c4d3875c64eb75787b19258/openapi/index.yaml"
}

# For named value io_messages_backend_key
data "azurerm_key_vault_secret" "io_messages_backend_func_key" {
  name         = "io-p-messages-backend-func-key"
  key_vault_id = module.key_vault.id
}

# For APIM API module apim_v2_messages_citizen_l1_api_v1
data "http" "messages_citizen_openapi" {
  url = "https://raw.githubusercontent.com/pagopa/io-messages/main/apps/citizen-func/openapi/index.yaml"
}
