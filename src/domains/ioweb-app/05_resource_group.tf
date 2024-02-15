resource "azurerm_resource_group" "base_rg" {
  name     = "${local.project}-rg"
  location = var.location

  tags = var.tags
}

# resource group for ioweb-profile azure function
resource "azurerm_resource_group" "ioweb_profile_rg" {
  name     = format("%s-ioweb-profile-rg", local.common_project)
  location = var.location

  tags = var.tags
}

data "azurerm_resource_group" "storage_rg" {
  name = "${local.common_project}-${var.domain}-storage-rg"
}
