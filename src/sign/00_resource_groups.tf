resource "azurerm_resource_group" "data_rg" {
  name     = "${local.project}-data-rg"
  location = var.location

  tags = var.tags
}

resource "azurerm_resource_group" "backend_rg" {
  name     = "${local.project}-backend-rg"
  location = var.location

  tags = var.tags
}

resource "azurerm_resource_group" "sec_rg" {
  name     = "${local.project}-sec-rg"
  location = var.location

  tags = var.tags
}
