data "azurerm_api_management" "apim_api" {
  name                = local.apim_name
  resource_group_name = local.apim_resource_group_name
}

resource "azurerm_api_management_group" "apithirdpartymessagewrite" {
  name                = "apithirdpartymessagewrite"
  api_management_name = data.azurerm_api_management.apim_api.name
  resource_group_name = data.azurerm_api_management.apim_api.resource_group_name
  display_name        = "ApiThirdPartyMessageWrite"
  description         = "A group that enables to send Third Party Messages"
}

resource "azurerm_api_management_group" "apimessagewriteadvanced" {
  name                = "apimessagewriteadvanced"
  api_management_name = data.azurerm_api_management.apim_api.name
  resource_group_name = data.azurerm_api_management.apim_api.resource_group_name
  display_name        = "ApiMessageWriteAdvanced"
  description         = "A group that enables to send Advanced Write Messages"
}

resource "azurerm_api_management_group" "apimessagereadadvanced" {
  name                = "apimessagereadadvanced"
  api_management_name = data.azurerm_api_management.apim_api.name
  resource_group_name = data.azurerm_api_management.apim_api.resource_group_name
  display_name        = "ApiMessageReadAdvanced"
  description         = "A group that enables to send Advanced Read Messages"
}

resource "azurerm_api_management_group" "apinewmessagenotify" {
  name                = "apinewmessagenotify"
  api_management_name = data.azurerm_api_management.apim_api.name
  resource_group_name = data.azurerm_api_management.apim_api.resource_group_name
  display_name        = "ApiNewMessageNotify"
  description         = "A group that enables to send a Push notification for a new message"
}

resource "azurerm_api_management_group" "apiremindernotify" {
  name                = "apiremindernotify"
  api_management_name = data.azurerm_api_management.apim_api.name
  resource_group_name = data.azurerm_api_management.apim_api.resource_group_name
  display_name        = "ApiReminderNotify"
  description         = "A group that enables to send a Push notification for a reminder message"
}

module "apim_product_notifications" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.16"

  product_id   = "io-notifications-api"
  display_name = "IO NOTIFICATIONS API"
  description  = "Product for IO notifications"

  api_management_name = data.azurerm_api_management.apim_api.name
  resource_group_name = data.azurerm_api_management.apim_api.resource_group_name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/messages/_base_policy.xml")
}

module "apim_service_messages_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-service-messages-api", local.product)
  api_management_name   = data.azurerm_api_management.apim_api.name
  resource_group_name   = data.azurerm_api_management.apim_api.resource_group_name
  product_ids           = [module.apim_product_notifications.product_id]
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


resource "azurerm_api_management_user" "reminder_user" {
  user_id             = "iopremiumreminderuser"
  api_management_name = data.azurerm_api_management.apim_api.name
  resource_group_name = data.azurerm_api_management.apim_api.resource_group_name
  first_name          = "Reminder"
  last_name           = "Reminder"
  email               = "io-premium-reminder@pagopa.it"
  state               = "active"
}

resource "azurerm_api_management_group_user" "reminder_group" {
  user_id             = azurerm_api_management_user.reminder_user.id
  group_name          = azurerm_api_management_group.apiremindernotify.name
  resource_group_name = azurerm_api_management_user.reminder_user.resource_group_name
  api_management_name = azurerm_api_management_user.reminder_user.api_management_name
}

resource "azurerm_api_management_subscription" "reminder" {
  api_management_name = data.azurerm_api_management.apim_api.name
  resource_group_name = data.azurerm_api_management.apim_api.resource_group_name
  user_id             = azurerm_api_management_user.reminder_user.id
  product_id          = module.apim_product_notifications.id
  display_name        = "Reminder API"
}

resource "azurerm_key_vault_secret" "reminder_subscription_primary_key" {
  name         = "${format("%s-reminder", local.product)}-subscription-key"
  value        = azurerm_api_management_subscription.reminder.primary_key
  content_type = "subscription key"
  key_vault_id = module.key_vault.id
}

