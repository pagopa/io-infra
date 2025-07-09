data "azurerm_storage_account" "logs" {
  name                = replace("${var.project}-stlogs", "-", "")
  resource_group_name = "${var.project}-rg-operations"
}

data "azurerm_storage_account" "notifications" {
  name                = replace("${var.project}-stnotifications", "-", "")
  resource_group_name = var.resource_group_internal
}

data "azurerm_storage_account" "itn_com_st" {
  name                = "iopitncomst01"
  resource_group_name = "io-p-itn-com-rg-01"
}
