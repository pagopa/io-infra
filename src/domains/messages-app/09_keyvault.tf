data "azurerm_key_vault" "common" {
  name                = format("%s-kv-common", local.product)
  resource_group_name = format("%s-rg-common", local.product)
}
