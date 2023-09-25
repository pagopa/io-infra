resource "azurerm_resource_group" "common_rg" {
  name     = "${local.project}-common-rg"
  location = var.location

  tags = var.tags
}

resource "azurerm_resource_group" "fe_rg" {
  name     = "${local.project}-fe-rg"
  location = var.location

  tags = var.tags
}

resource "azurerm_resource_group" "storage_rg" {
  name     = "${local.project}-storage-rg"
  location = var.location

  tags = var.tags
}
