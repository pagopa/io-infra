data "azurerm_storage_account" "storage_apievents" {
  name                = replace(format("%s-stapievents", local.project), "-", "")
  resource_group_name = format("%s-rg-internal", local.project)
}

resource "azurerm_storage_queue" "storage_account_apievents_events_queue" {
  name                 = "events"
  storage_account_name = data.azurerm_storage_account.storage_apievents.name
}