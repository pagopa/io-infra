module "storage_account_itn_elt" {
  source  = "pagopa-dx/azure-storage-account/azurerm"
  version = "~> 2.0"

  environment = {
    prefix          = var.prefix
    env_short       = var.env_short
    location        = var.location_itn
    app_name        = "elt"
    instance_number = "02"
  }
  resource_group_name = var.resource_group_name
  use_case            = "default"
  subnet_pep_id       = data.azurerm_subnet.private_endpoints_subnet_itn.id

  subservices_enabled = {
    blob  = true
    queue = true
    table = true
  }

  blob_features = {
    versioning = true
    change_feed = {
      enabled = true
    }
  }

  action_group_id = data.azurerm_monitor_action_group.error_action_group.id

  tags = var.tags
}

resource "azurerm_storage_container" "messages_step_final_itn" {
  name                  = "messages-report-step-final"
  storage_account_name  = module.storage_account_itn_elt.name
  storage_account_id    = module.storage_account_itn_elt.id
  container_access_type = "private"
}



resource "azurerm_storage_container" "messages_report_step1_itn" {
  name                  = "messages-report-step1"
  storage_account_name  = module.storage_account_itn_elt.name
  storage_account_id    = module.storage_account_itn_elt.id
  container_access_type = "private"
}



resource "azurerm_storage_table" "fnelterrors_itn" {
  name                 = "fnelterrors"
  storage_account_name = module.storage_account_itn_elt.name
}



resource "azurerm_storage_table" "fnelterrors_messages_itn" {
  name                 = "fnelterrorsMessages"
  storage_account_name = module.storage_account_itn_elt.name
}



resource "azurerm_storage_table" "fnelterrors_message_status_itn" {
  name                 = "fnelterrorsMessageStatus"
  storage_account_name = module.storage_account_itn_elt.name
}



resource "azurerm_storage_table" "fnelterrors_notification_status_itn" {
  name                 = "fnelterrorsNotificationStatus"
  storage_account_name = module.storage_account_itn_elt.name
}



resource "azurerm_storage_table" "fneltcommands_itn" {
  name                 = "fneltcommands"
  storage_account_name = module.storage_account_itn_elt.name
}



resource "azurerm_storage_table" "fneltexports_itn" {
  name                 = "fneltexports"
  storage_account_name = module.storage_account_itn_elt.name
}

