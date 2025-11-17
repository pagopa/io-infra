module "services_storage_account_01" {
  source  = "pagopa-dx/azure-storage-account/azurerm"
  version = "~> 1.0"

  environment = {
    prefix          = var.prefix
    env_short       = var.env_short
    location        = var.location_itn
    app_name        = "services"
    instance_number = "01"
  }
  resource_group_name = azurerm_resource_group.function_services_rg.name
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

resource "azurerm_storage_management_policy" "processing_messages_container_rule_01" {
  storage_account_id = module.services_storage_account_01.id

  rule {
    name    = "deleteafterdays"
    enabled = true
    filters {
      prefix_match = ["processing-messages"]
      blob_types   = ["blockBlob"]
    }
    actions {
      base_blob {
        delete_after_days_since_creation_greater_than = 1
      }
      snapshot {
        delete_after_days_since_creation_greater_than = 1
      }
      version {
        delete_after_days_since_creation = 1
      }
    }
  }
}



################################
# Queue
################################

resource "azurerm_storage_queue" "message-created-01" {
  name                 = "message-created"
  storage_account_name = module.services_storage_account_01.name
}

resource "azurerm_storage_queue" "message-created-poison-01" {
  name                 = "message-created-poison"
  storage_account_name = module.services_storage_account_01.name
}

resource "azurerm_storage_queue" "message-processed-01" {
  name                 = "message-processed"
  storage_account_name = module.services_storage_account_01.name
}

resource "azurerm_storage_queue" "message-processed-poison-01" {
  name                 = "message-processed-poison"
  storage_account_name = module.services_storage_account_01.name
}

resource "azurerm_storage_queue" "notification-created-email-01" {
  name                 = "notification-created-email"
  storage_account_name = module.services_storage_account_01.name
}

resource "azurerm_storage_queue" "notification-created-email-poison-01" {
  name                 = "notification-created-email-poison"
  storage_account_name = module.services_storage_account_01.name
}

resource "azurerm_storage_queue" "notification-created-webhook-poison-01" {
  name                 = "notification-created-webhook-poison"
  storage_account_name = module.services_storage_account_01.name
}

################################
# Container
################################
resource "azurerm_storage_container" "processing-messages-01" {
  name               = "processing-messages"
  storage_account_id = module.services_storage_account_01.id
}
