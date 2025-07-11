data "azurerm_storage_account" "lollipop_assertion_storage" {
  name                = replace(format("%s-lollipop-assertions-st", local.product), "-", "")
  resource_group_name = format("%s-%s-data-rg", local.product, var.domain)
}

data "azurerm_storage_account" "logs" {
  name                = replace(format("%s-stlogs", local.product), "-", "")
  resource_group_name = format("%s-rg-operations", local.product)
}

data "azurerm_storage_account" "push_notifications_storage" {
  name                = replace(format("%s-com-st-01", local.common_project_itn), "-", "")
  resource_group_name = format("%s-com-rg-01", local.common_project_itn)
}
