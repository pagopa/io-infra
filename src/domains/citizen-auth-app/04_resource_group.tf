data "azurerm_resource_group" "rg_internal" {
  name = format("%s-rg-internal", local.product)
}

data "azurerm_resource_group" "rg_common" {
  name = format("%s-rg-common", local.product)
}
