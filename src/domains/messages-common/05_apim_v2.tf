data "azurerm_api_management" "apim_v2_api" {
  name                = local.apim_v2_name
  resource_group_name = local.apim_resource_group_name
}

resource "azurerm_api_management_group" "apithirdpartymessagewrite_v2" {
  name                = "apithirdpartymessagewrite"
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  display_name        = "ApiThirdPartyMessageWrite"
  description         = "A group that enables to send Third Party Messages"
}

resource "azurerm_api_management_group" "apimessagewriteadvanced_v2" {
  name                = "apimessagewriteadvanced"
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  display_name        = "ApiMessageWriteAdvanced"
  description         = "A group that enables to send Advanced Write Messages"
}

resource "azurerm_api_management_group" "apimessagereadadvanced_v2" {
  name                = "apimessagereadadvanced"
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  display_name        = "ApiMessageReadAdvanced"
  description         = "A group that enables to send Advanced Read Messages"
}

resource "azurerm_api_management_group" "apinewmessagenotify_v2" {
  name                = "apinewmessagenotify"
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  display_name        = "ApiNewMessageNotify"
  description         = "A group that enables to send a Push notification for a new message"
}

resource "azurerm_api_management_group" "apiremindernotify_v2" {
  name                = "apiremindernotify"
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  display_name        = "ApiReminderNotify"
  description         = "A group that enables to send a Push notification for a reminder message"
}

resource "azurerm_api_management_group" "apipaymentupdater_v2" {
  name                = "apipaymentread"
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  display_name        = "ApiPaymentRead"
  description         = "A group that enables to read payment status related to a message"
}

module "apim_v2_product_notifications" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//api_management_product?ref=v4.1.5"

  product_id   = "io-notifications-api"
  display_name = "IO NOTIFICATIONS API"
  description  = "Product for IO notifications"

  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/messages/_base_policy.xml")
}

module "apim_v2_service_messages_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//api_management_api?ref=v4.1.5"

  name                  = format("%s-service-messages-api", local.product)
  api_management_name   = data.azurerm_api_management.apim_v2_api.name
  resource_group_name   = data.azurerm_api_management.apim_v2_api.resource_group_name
  product_ids           = [module.apim_v2_product_notifications.product_id]
  subscription_required = true
  service_url           = null

  description  = "IO Service - Messages API"
  display_name = "IO Service - Messages API"
  path         = "service-messages/api/v1"
  protocols    = ["https"]

  content_format = "openapi"

  content_value = file("./api/service-messages/v1/_openapi.yaml")

  xml_content = file("./api/service-messages/v1/_base_policy.xml")
}

module "io-backend_notification_v2_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//api_management_api?ref=v4.1.5"

  name                  = format("%s-io-backend-notification-api", local.product)
  api_management_name   = data.azurerm_api_management.apim_v2_api.name
  resource_group_name   = data.azurerm_api_management.apim_v2_api.resource_group_name
  product_ids           = [module.apim_v2_product_notifications.product_id]
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

resource "azurerm_api_management_user" "reminder_user_v2" {
  user_id             = "iopremiumreminderuser"
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  first_name          = "Reminder"
  last_name           = "Reminder"
  email               = "io-premium-reminder@pagopa.it"
  state               = "active"
}

resource "azurerm_api_management_group_user" "reminder_group_v2" {
  user_id             = azurerm_api_management_user.reminder_user_v2.user_id
  group_name          = azurerm_api_management_group.apiremindernotify_v2.name
  resource_group_name = azurerm_api_management_user.reminder_user_v2.resource_group_name
  api_management_name = azurerm_api_management_user.reminder_user_v2.api_management_name
}

resource "azurerm_api_management_subscription" "reminder_v2" {
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  user_id             = azurerm_api_management_user.reminder_user_v2.id
  product_id          = module.apim_v2_product_notifications.id
  display_name        = "Reminder API"
  state               = "active"
  allow_tracing       = false
}

resource "azurerm_key_vault_secret" "reminder_subscription_primary_key_v2" {
  name         = "${format("%s-reminder", local.product)}-subscription-key-v2"
  value        = azurerm_api_management_subscription.reminder_v2.primary_key
  content_type = "subscription key"
  key_vault_id = module.key_vault.id
}

########################################

data "azurerm_api_management_product" "payment_updater_product_v2" {
  product_id          = "io-payments-api"
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
}

resource "azurerm_api_management_group_user" "payment_group_v2" {
  user_id             = azurerm_api_management_user.reminder_user_v2.user_id
  group_name          = azurerm_api_management_group.apipaymentupdater_v2.name
  resource_group_name = azurerm_api_management_user.reminder_user_v2.resource_group_name
  api_management_name = azurerm_api_management_user.reminder_user_v2.api_management_name
}

resource "azurerm_api_management_subscription" "payment_updater_reminder_v2" {
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  user_id             = azurerm_api_management_user.reminder_user_v2.id
  product_id          = data.azurerm_api_management_product.payment_updater_product_v2.id
  display_name        = "Payment Updater API"
  state               = "active"
  allow_tracing       = false
}

resource "azurerm_key_vault_secret" "reminder_paymentapi_subscription_primary_key_v2" {
  name         = "${format("%s-reminder-payment-api", local.product)}-subscription-key-v2"
  value        = azurerm_api_management_subscription.payment_updater_reminder_v2.primary_key
  content_type = "subscription key"
  key_vault_id = module.key_vault.id
}
