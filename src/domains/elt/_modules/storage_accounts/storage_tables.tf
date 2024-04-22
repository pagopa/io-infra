resource "azurerm_storage_table" "fnelterrors" {
  name                 = "fnelterrors"
  storage_account_name = module.storage_account_elt.name
}

resource "azurerm_storage_table" "fnelterrors_messages" {
  name                 = "fnelterrorsMessages"
  storage_account_name = module.storage_account_elt.name
}

resource "azurerm_storage_table" "fnelterrors_message_status" {
  name                 = "fnelterrorsMessageStatus"
  storage_account_name = module.storage_account_elt.name
}

resource "azurerm_storage_table" "fnelterrors_notification_status" {
  name                 = "fnelterrorsNotificationStatus"
  storage_account_name = module.storage_account_elt.name
}

resource "azurerm_storage_table" "fneltcommands" {
  name                 = "fneltcommands"
  storage_account_name = module.storage_account_elt.name
}

resource "azurerm_storage_table" "fneltexports" {
  name                 = "fneltexports"
  storage_account_name = module.storage_account_elt.name
}

resource "azurerm_storage_container" "container_messages_report_step1" {
  name                  = "messages-report-step1"
  storage_account_name  = module.storage_account_elt.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "container_messages_report_step_final" {
  name                  = "messages-report-step-final"
  storage_account_name  = module.storage_account_elt.name
  container_access_type = "private"
}
