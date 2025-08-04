################################
# Queue
################################
resource "azurerm_storage_queue" "message_created" {
  for_each = {
    for idx, mod in module.function_services_dx :
    idx => {
      index                = idx
      storage_account_name = mod.storage_account.name
    }
  }

  name                 = "message-created"
  storage_account_name = each.value.storage_account_name
}

resource "azurerm_storage_queue" "message-created-poison" {
  for_each = {
    for idx, mod in module.function_services_dx :
    idx => {
      index                = idx
      storage_account_name = mod.storage_account.name
    }
  }

  name                 = "message-created-poison"
  storage_account_name = each.value.storage_account_name
}

resource "azurerm_storage_queue" "message-processed" {
  for_each = {
    for idx, mod in module.function_services_dx :
    idx => {
      index                = idx
      storage_account_name = mod.storage_account.name
    }
  }

  name                 = "message-processed"
  storage_account_name = each.value.storage_account_name
}

resource "azurerm_storage_queue" "message-processed-poison" {
  for_each = {
    for idx, mod in module.function_services_dx :
    idx => {
      index                = idx
      storage_account_name = mod.storage_account.name
    }
  }

  name                 = "message-processed-poison"
  storage_account_name = each.value.storage_account_name
}

resource "azurerm_storage_queue" "notification-created-email" {
  for_each = {
    for idx, mod in module.function_services_dx :
    idx => {
      index                = idx
      storage_account_name = mod.storage_account.name
    }
  }

  name                 = "notification-created-email"
  storage_account_name = each.value.storage_account_name
}

resource "azurerm_storage_queue" "notification-created-email-poison" {
  for_each = {
    for idx, mod in module.function_services_dx :
    idx => {
      index                = idx
      storage_account_name = mod.storage_account.name
    }
  }

  name                 = "notification-created-email-poison"
  storage_account_name = each.value.storage_account_name
}

resource "azurerm_storage_queue" "notification-created-webhook" {
  for_each = {
    for idx, mod in module.function_services_dx :
    idx => {
      index                = idx
      storage_account_name = mod.storage_account.name
    }
  }

  name                 = "notification-created-webhook"
  storage_account_name = each.value.storage_account_name
}

resource "azurerm_storage_queue" "notification-created-webhook-poison" {
  for_each = {
    for idx, mod in module.function_services_dx :
    idx => {
      index                = idx
      storage_account_name = mod.storage_account.name
    }
  }

  name                 = "notification-created-webhook-poison"
  storage_account_name = each.value.storage_account_name
}

################################
# Container
################################
resource "azurerm_storage_container" "processing-messages" {
  for_each = {
    for idx, mod in module.function_services_dx :
    idx => {
      index              = idx
      storage_account_id = mod.storage_account.id
    }
  }

  name               = "processing-messages"
  storage_account_id = each.value.storage_account_id
}
