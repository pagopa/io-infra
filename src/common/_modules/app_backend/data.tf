data "azurerm_storage_account" "locked_profiles_storage" {
  name                = replace("${var.project}-locked-profiles-st", "-", "")
  resource_group_name = "${var.project}-rg-internal"
}

data "azurerm_storage_account" "lollipop_assertions_storage" {
  name                = replace("${var.project}-${var.citizen_auth_assertion_storage_name}", "-", "")
  resource_group_name = "${var.project}-citizen-auth-data-rg"
}

data "azurerm_storage_account" "logs" {
  name                = replace("${var.project}-stlogs", "-", "")
  resource_group_name = "${var.project}-rg-operations"
}

data "azurerm_storage_account" "notifications" {
  name                = replace("${var.project}-stnotifications", "-", "")
  resource_group_name = var.resource_group_internal
}

data "azurerm_storage_account" "push_notifications_storage" {
  name                = replace(format("${var.project}-weu-messages-notifst"), "-", "")
  resource_group_name = "${var.project}-weu-messages-notifications-rg"
}

data "azurerm_storage_account" "itn_com_st" {
  name                = "iopitncomst01"
  resource_group_name = "io-p-itn-com-rg-01"
}
