################################
# Queue
################################

resource "azurerm_storage_queue" "message-created" {
  name                 = "message-created"
  storage_account_name = module.function_services_dx.storage_account.name
}

resource "azurerm_storage_queue" "message-created-poison" {
  name                 = "message-created-poison"
  storage_account_name = module.function_services_dx.storage_account.name
}

resource "azurerm_storage_queue" "message-processed" {
  name                 = "message-processed"
  storage_account_name = module.function_services_dx.storage_account.name
}

resource "azurerm_storage_queue" "message-processed-poison" {
  name                 = "message-processed-poison"
  storage_account_name = module.function_services_dx.storage_account.name
}

resource "azurerm_storage_queue" "notification-created-email" {
  name                 = "notification-created-email"
  storage_account_name = module.function_services_dx.storage_account.name
}

resource "azurerm_storage_queue" "notification-created-email-poison" {
  name                 = "notification-created-email-poison"
  storage_account_name = module.function_services_dx.storage_account.name
}

resource "azurerm_storage_queue" "notification-created-webhook-poison" {
  name                 = "notification-created-webhook-poison"
  storage_account_name = module.function_services_dx.storage_account.name
}

################################
# Container
################################
resource "azurerm_storage_container" "processing-messages" {
  name               = "processing-messages"
  storage_account_id = module.function_services_dx.storage_account.id
}
