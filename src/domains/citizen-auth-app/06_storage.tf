data "azurerm_storage_account" "lollipop_assertion_storage" {
  name                = replace(format("%s-lollipop-assertions-st", local.product), "-", "")
  resource_group_name = format("%s-%s-data-rg", local.product, var.domain)
}

data "azurerm_storage_account" "lv_audit_logs_storage" {
  name                = replace(format("%s-lv-logs-st", local.product), "-", "")
  resource_group_name = format("%s-%s-data-rg", local.product, var.domain)
}

data "azurerm_storage_account" "unique_emails_storage" {
  name                = replace(format("%s-unique-emails-st", local.product), "-", "")
  resource_group_name = format("%s-%s-data-rg", local.product, var.domain)
}
