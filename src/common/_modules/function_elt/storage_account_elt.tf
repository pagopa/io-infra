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
  container_access_type = "private"
}

import {
  to = azurerm_storage_container.messages_step_final_itn
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-elt-rg-01/providers/Microsoft.Storage/storageAccounts/iopitneltst02/blobServices/default/containers/messages-report-step-final"
}

resource "azurerm_storage_container" "messages_report_step1_itn" {
  name                  = "messages-report-step1"
  storage_account_name  = module.storage_account_itn_elt.name
  container_access_type = "private"
}

import {
  to = azurerm_storage_container.messages_report_step1_itn
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-elt-rg-01/providers/Microsoft.Storage/storageAccounts/iopitneltst02/blobServices/default/containers/messages-report-step1"
}

resource "azurerm_storage_table" "fnelterrors_itn" {
  name                 = "fnelterrors"
  storage_account_name = module.storage_account_itn_elt.name
}

import {
  to = azurerm_storage_table.fnelterrors_itn
  id = "https://iopitneltst02.table.core.windows.net/Tables('fnelterrors')"
}

resource "azurerm_storage_table" "fnelterrors_messages_itn" {
  name                 = "fnelterrorsMessages"
  storage_account_name = module.storage_account_itn_elt.name
}

import {
  to = azurerm_storage_table.fnelterrors_messages_itn
  id = "https://iopitneltst02.table.core.windows.net/Tables('fnelterrorsMessages')"
}

resource "azurerm_storage_table" "fnelterrors_message_status_itn" {
  name                 = "fnelterrorsMessageStatus"
  storage_account_name = module.storage_account_itn_elt.name
}

import {
  to = azurerm_storage_table.fnelterrors_message_status_itn
  id = "https://iopitneltst02.table.core.windows.net/Tables('fnelterrorsMessageStatus')"
}

resource "azurerm_storage_table" "fnelterrors_notification_status_itn" {
  name                 = "fnelterrorsNotificationStatus"
  storage_account_name = module.storage_account_itn_elt.name
}

import {
  to = azurerm_storage_table.fnelterrors_notification_status_itn
  id = "https://iopitneltst02.table.core.windows.net/Tables('fnelterrorsNotificationStatus')"
}

resource "azurerm_storage_table" "fneltcommands_itn" {
  name                 = "fneltcommands"
  storage_account_name = module.storage_account_itn_elt.name
}

import {
  to = azurerm_storage_table.fneltcommands_itn
  id = "https://iopitneltst02.table.core.windows.net/Tables('fneltcommands')"
}

resource "azurerm_storage_table" "fneltexports_itn" {
  name                 = "fneltexports"
  storage_account_name = module.storage_account_itn_elt.name
}

import {
  to = azurerm_storage_table.fneltexports_itn
  id = "https://iopitneltst02.table.core.windows.net/Tables('fneltexports')"
}
