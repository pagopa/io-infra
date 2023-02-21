data "azurerm_storage_account" "lollipop_assertion_storage" {
  name                = replace(format("%s-lollipop-assertions-st", local.product), "-", "")
  resource_group_name = format("%s-%s-data-rg", local.product, var.domain)
}