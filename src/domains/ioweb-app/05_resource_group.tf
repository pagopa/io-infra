data "azurerm_resource_group" "storage_rg" {
  name = "${local.common_project}-${var.domain}-storage-rg"
}

data "azurerm_resource_group" "italy_north_common_rg" {
  name = format("%s-itn-common-rg-01", local.product)
}
