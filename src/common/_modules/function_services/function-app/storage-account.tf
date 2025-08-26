module "services_storage_account" {
  source  = "pagopa-dx/azure-storage-account/azurerm"
  version = "~> 1.0"

  environment = {
    prefix          = var.prefix
    env_short       = var.env_short
    location        = var.location_itn
    app_name        = "funcsvc"
    instance_number = "01"
  }
  resource_group_name = data.azurerm_resource_group.services_itn_rg.name
  tier                = "l"
  subnet_pep_id       = data.azurerm_subnet.private_endpoints_subnet_itn.id

  subservices_enabled = {
    blob  = true
    queue = true
  }

  blob_features = {
    versioning = true
  }

  action_group_id = data.azurerm_monitor_action_group.error_action_group.id

  tags = var.tags
}



################################
# Queue
################################

resource "azurerm_storage_queue" "message-created" {
  name                 = "message-created"
  storage_account_name = module.services_storage_account.name
}

resource "azurerm_storage_queue" "message-created-poison" {
  name                 = "message-created-poison"
  storage_account_name = module.services_storage_account.name
}

resource "azurerm_storage_queue" "message-processed" {
  name                 = "message-processed"
  storage_account_name = module.services_storage_account.name
}

resource "azurerm_storage_queue" "message-processed-poison" {
  name                 = "message-processed-poison"
  storage_account_name = module.services_storage_account.name
}

resource "azurerm_storage_queue" "notification-created-email" {
  name                 = "notification-created-email"
  storage_account_name = module.services_storage_account.name
}

resource "azurerm_storage_queue" "notification-created-email-poison" {
  name                 = "notification-created-email-poison"
  storage_account_name = module.services_storage_account.name
}

resource "azurerm_storage_queue" "notification-created-webhook-poison" {
  name                 = "notification-created-webhook-poison"
  storage_account_name = module.services_storage_account.name
}

################################
# Container
################################
resource "azurerm_storage_container" "processing-messages" {
  name               = "processing-messages"
  storage_account_id = module.services_storage_account.id
}
