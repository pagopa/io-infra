resource "azurerm_api_management_group" "apiremotecontentconfigurationwrite_itn" {
  name                = "apiremotecontentconfigurationwrite"
  api_management_name = data.azurerm_api_management.apim_itn_api.name
  resource_group_name = data.azurerm_api_management.apim_itn_api.resource_group_name
  display_name        = "ApiRemoteContentConfigurationWrite"
  description         = "A group that enables to write and manage Remote Content Configuration"
}

resource "azurerm_api_management_group" "apithirdpartymessagewrite_itn" {
  name                = "apithirdpartymessagewrite"
  api_management_name = data.azurerm_api_management.apim_itn_api.name
  resource_group_name = data.azurerm_api_management.apim_itn_api.resource_group_name
  display_name        = "ApiThirdPartyMessageWrite"
  description         = "A group that enables to send Third Party Messages"
}

resource "azurerm_api_management_group" "apimessagewriteadvanced_itn" {
  name                = "apimessagewriteadvanced"
  api_management_name = data.azurerm_api_management.apim_itn_api.name
  resource_group_name = data.azurerm_api_management.apim_itn_api.resource_group_name
  display_name        = "ApiMessageWriteAdvanced"
  description         = "A group that enables to send Advanced Write Messages"
}

resource "azurerm_api_management_group" "apimessagereadadvanced_itn" {
  name                = "apimessagereadadvanced"
  api_management_name = data.azurerm_api_management.apim_itn_api.name
  resource_group_name = data.azurerm_api_management.apim_itn_api.resource_group_name
  display_name        = "ApiMessageReadAdvanced"
  description         = "A group that enables to send Advanced Read Messages"
}

resource "azurerm_api_management_group" "apinewmessagenotify_itn" {
  name                = "apinewmessagenotify"
  api_management_name = data.azurerm_api_management.apim_itn_api.name
  resource_group_name = data.azurerm_api_management.apim_itn_api.resource_group_name
  display_name        = "ApiNewMessageNotify"
  description         = "A group that enables to send a Push notification for a new message"
}

resource "azurerm_api_management_group" "apiremindernotify_itn" {
  name                = "apiremindernotify"
  api_management_name = data.azurerm_api_management.apim_itn_api.name
  resource_group_name = data.azurerm_api_management.apim_itn_api.resource_group_name
  display_name        = "ApiReminderNotify"
  description         = "A group that enables to send a Push notification for a reminder message"
}

resource "azurerm_api_management_group" "apipaymentupdater_itn" {
  name                = "apipaymentread"
  api_management_name = data.azurerm_api_management.apim_itn_api.name
  resource_group_name = data.azurerm_api_management.apim_itn_api.resource_group_name
  display_name        = "ApiPaymentRead"
  description         = "A group that enables to read payment status related to a message"
}

module "apim_itn_product_notifications" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_product?ref=v8.27.0"

  product_id   = "io-notifications-api"
  display_name = "IO NOTIFICATIONS API"
  description  = "Product for IO notifications"

  api_management_name = data.azurerm_api_management.apim_itn_api.name
  resource_group_name = data.azurerm_api_management.apim_itn_api.resource_group_name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/messages/_base_policy.xml")
}

module "io-backend_notification_itn_api_v1" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_api?ref=v8.27.0"

  name                  = format("%s-io-backend-notification-api", local.product)
  api_management_name   = data.azurerm_api_management.apim_itn_api.name
  resource_group_name   = data.azurerm_api_management.apim_itn_api.resource_group_name
  product_ids           = [module.apim_itn_product_notifications.product_id]
  subscription_required = false
  service_url           = null

  description  = "IO Backend - Notification API"
  display_name = "IO Backend - Notification API"
  path         = "io-backend-notification/api/v1"
  protocols    = ["https"]

  content_format = "openapi"

  content_value = file("./api/io-backend-notification/v1/_openapi.yaml")

  xml_content = file("./api/io-backend-notification/v1/_base_policy.xml")
}

resource "azurerm_api_management_user" "reminder_user_itn" {
  user_id             = "iopremiumreminderuser"
  api_management_name = data.azurerm_api_management.apim_itn_api.name
  resource_group_name = data.azurerm_api_management.apim_itn_api.resource_group_name
  first_name          = "Reminder"
  last_name           = "Reminder"
  email               = "io-premium-reminder@pagopa.it"
  state               = "active"
}

resource "azurerm_api_management_group_user" "reminder_group_itn" {
  user_id             = azurerm_api_management_user.reminder_user_itn.user_id
  group_name          = azurerm_api_management_group.apiremindernotify_itn.name
  resource_group_name = azurerm_api_management_user.reminder_user_itn.resource_group_name
  api_management_name = azurerm_api_management_user.reminder_user_itn.api_management_name
}

resource "azurerm_api_management_subscription" "reminder_itn" {
  api_management_name = data.azurerm_api_management.apim_itn_api.name
  resource_group_name = data.azurerm_api_management.apim_itn_api.resource_group_name
  user_id             = azurerm_api_management_user.reminder_user_itn.id
  product_id          = module.apim_itn_product_notifications.id
  display_name        = "Reminder API"
  state               = "active"
  allow_tracing       = false
}

resource "azurerm_key_vault_secret" "reminder_subscription_primary_key_itn" {
  name         = "${format("%s-reminder", local.product)}-subscription-key-itn"
  value        = azurerm_api_management_subscription.reminder_itn.primary_key
  content_type = "subscription key"
  key_vault_id = module.key_vault.id
}

########################################
resource "azurerm_api_management_group_user" "payment_group_itn" {
  user_id             = azurerm_api_management_user.reminder_user_itn.user_id
  group_name          = azurerm_api_management_group.apipaymentupdater_itn.name
  resource_group_name = azurerm_api_management_user.reminder_user_itn.resource_group_name
  api_management_name = azurerm_api_management_user.reminder_user_itn.api_management_name
}

resource "azurerm_api_management_subscription" "payment_updater_reminder_itn" {
  api_management_name = data.azurerm_api_management.apim_itn_api.name
  resource_group_name = data.azurerm_api_management.apim_itn_api.resource_group_name
  user_id             = azurerm_api_management_user.reminder_user_itn.id
  product_id          = data.azurerm_api_management_product.payment_updater_product_v2.id
  display_name        = "Payment Updater API"
  state               = "active"
  allow_tracing       = false
}

resource "azurerm_key_vault_secret" "reminder_paymentapi_subscription_primary_key_itn" {
  name         = "${format("%s-reminder-payment-api", local.product)}-subscription-key-itn"
  value        = azurerm_api_management_subscription.payment_updater_reminder_itn.primary_key
  content_type = "subscription key"
  key_vault_id = module.key_vault.id
}

###############################################
################ API MANAGE ###################
###############################################

resource "azurerm_api_management_named_value" "io_p_messages_sending_func_key_itn" {
  name                = "io-p-messages-sending-func-key"
  display_name        = "io-p-messages-sending-func-key"
  api_management_name = data.azurerm_api_management.apim_itn_api.name
  resource_group_name = data.azurerm_api_management.apim_itn_api.resource_group_name
  value               = data.azurerm_key_vault_secret.io_p_messages_sending_func_key.value
  secret              = "true"
}

# APIM APIs

# MESSAGES SENDING FUNC EXTERNAL
module "apim_itn_messages_sending_external_api_v1" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_api?ref=v8.17.0"

  name                  = format("%s-%s-messages-sending-external-api-01", local.product, var.location_short)
  api_management_name   = data.azurerm_api_management.apim_itn_api.name
  resource_group_name   = data.azurerm_api_management.apim_itn_api.resource_group_name
  product_ids           = [data.azurerm_api_management_product.apim_v2_product_services.product_id]
  subscription_required = true
  service_url           = null

  description  = "IO Messages Sending - External - API"
  display_name = "IO Messages Sending - External - API"
  path         = "api/v1/messages-sending"
  protocols    = ["https"]

  content_format = "openapi"
  content_value  = data.http.messages_sending_external_openapi.body

  xml_content = file("./api/messages-sending/v1/_base_policy_external.xml")
}

# MESSAGES SENDING FUNC INTERNAL
module "apim_itn_messages_sending_internal_api_v1" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_api?ref=v8.27.0"

  name                  = format("%s-%s-messages-sending-internal-api-01", local.product, var.location_short)
  api_management_name   = data.azurerm_api_management.apim_itn_api.name
  resource_group_name   = data.azurerm_api_management.apim_itn_api.resource_group_name
  product_ids           = [module.apim_itn_product_notifications.product_id]
  subscription_required = true
  service_url           = null

  description  = "IO Messages Sending - Internal - API"
  display_name = "IO Messages Sending - Internal - API"
  path         = "api/v1/messages-sending/internal"
  protocols    = ["https"]

  content_format = "openapi"
  content_value  = data.http.messages_sending_internal_openapi.body

  xml_content = file("./api/messages-sending/v1/_base_policy_internal.xml")
}

# SERVICE MESSAGE MANAGE (TO REMOVE)
module "apim_itn_service_messages_manage_api_v1" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_api?ref=v8.27.0"

  name                  = format("%s-service-messages-manage-api", local.product)
  api_management_name   = data.azurerm_api_management.apim_itn_api.name
  resource_group_name   = data.azurerm_api_management.apim_itn_api.resource_group_name
  product_ids           = [data.azurerm_api_management_product.apim_itn_product_services.product_id]
  subscription_required = true
  service_url           = null

  description  = "IO Service Messages - Manage - API"
  display_name = "IO Service Messages - Manage - API"
  path         = "service-messages/manage/api/v1"
  protocols    = ["https"]

  content_format = "openapi"
  content_value  = data.http.service_messages_manage_openapi.body

  xml_content = file("./api/service-messages/v1/_base_policy.xml")
}

# SERVICE MESSAGE INTERNAL (TO REMOVE)
module "apim_itn_service_messages_internal_api_v1" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_api?ref=v8.27.0"

  name                  = format("%s-service-messages-internal-api", local.product)
  api_management_name   = data.azurerm_api_management.apim_itn_api.name
  resource_group_name   = data.azurerm_api_management.apim_itn_api.resource_group_name
  product_ids           = [module.apim_itn_product_notifications.product_id]
  subscription_required = true
  service_url           = null

  description  = "IO Service Messages - Internal - API"
  display_name = "IO Service Messages - Internal - API"
  path         = "service-messages/api/v1"
  protocols    = ["https"]

  content_format = "openapi"
  content_value  = data.http.service_messages_internal_openapi.body

  xml_content = file("./api/service-messages/v1/_base_policy.xml")
}

# MESSAGES CITIZEN FUNC
module "apim_itn_product_messages_backend" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_product?ref=v8.27.0"

  product_id   = "io-messages-backend-api"
  display_name = "IO MESSAGES BACKEND API"
  description  = "Product for IO MESSAGES BACKEND API"

  api_management_name = data.azurerm_api_management.apim_itn_api.name
  resource_group_name = data.azurerm_api_management.apim_itn_api.resource_group_name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/backend/_base_policy.xml")
}


resource "azurerm_api_management_subscription" "messages_backend_itn" {
  api_management_name = data.azurerm_api_management.apim_itn_api.name
  resource_group_name = data.azurerm_api_management.apim_itn_api.resource_group_name
  product_id          = module.apim_itn_product_messages_backend.id
  display_name        = "Messages Backend API"
  state               = "active"
  allow_tracing       = false
}

resource "azurerm_api_management_named_value" "io_messages_backend_key_itn" {
  name                = "io-messages-backend-key"
  api_management_name = data.azurerm_api_management.apim_itn_api.name
  resource_group_name = data.azurerm_api_management.apim_itn_api.resource_group_name
  display_name        = "io-messages-backend-key"
  value               = data.azurerm_key_vault_secret.io_messages_backend_func_key.value
  secret              = "true"
}

module "apim_itn_messages_citizen_l1_api_v1" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_api?ref=v8.40.0"

  name                  = format("%s-%s-messages-citizen-api-01", local.product, var.location_short)
  api_management_name   = data.azurerm_api_management.apim_itn_api.name
  resource_group_name   = data.azurerm_api_management.apim_itn_api.resource_group_name
  product_ids           = [module.apim_itn_product_messages_backend.product_id]
  subscription_required = true
  service_url           = null

  subscription_key_names = {
    header = "x-functions-key"
    query  = "subscription-key"
  }

  description  = "IO Messages Citizen - L1 - API"
  display_name = "IO Messages Citizen - L1 - API"
  path         = "messages/l1/api/v1"
  protocols    = ["https"]

  content_format = "openapi"
  content_value  = data.http.messages_citizen_openapi.body

  xml_content = file("./api/messages-citizen/v1/_base_policy_l1.xml")
}

module "apim_itn_messages_citizen_l2_api_v1" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_api?ref=v8.40.0"

  name                  = format("%s-%s-messages-citizen-api-02", local.product, var.location_short)
  api_management_name   = data.azurerm_api_management.apim_itn_api.name
  resource_group_name   = data.azurerm_api_management.apim_itn_api.resource_group_name
  product_ids           = [module.apim_itn_product_messages_backend.product_id]
  subscription_required = true
  service_url           = null

  description  = "IO Messages Citizen - L2 - API"
  display_name = "IO Messages Citizen - L2 - API"
  path         = "messages/l2/api/v1"
  protocols    = ["https"]

  subscription_key_names = {
    header = "x-functions-key"
    query  = "subscription-key"
  }

  content_format = "openapi"
  content_value  = data.http.messages_citizen_openapi.body

  xml_content = file("./api/messages-citizen/v1/_base_policy_l2.xml")
}