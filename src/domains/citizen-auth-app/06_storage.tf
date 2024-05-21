data "azurerm_storage_account" "lollipop_assertion_storage" {
  name                = replace(format("%s-lollipop-assertions-st", local.product), "-", "")
  resource_group_name = format("%s-%s-data-rg", local.product, var.domain)
}

data "azurerm_storage_account" "immutable_lv_audit_logs_storage" {
  name                = replace(format("%s-lv-logs-im-st", local.product), "-", "")
  resource_group_name = format("%s-%s-data-rg", local.product, var.domain)
}

data "azurerm_storage_account" "logs" {
  name                = replace(format("%s-stlogs", local.product), "-", "")
  resource_group_name = format("%s-rg-operations", local.product)
}
