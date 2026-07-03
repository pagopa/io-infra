resource "azurerm_resource_group" "platform" {
  name     = "${local.project}-platform-rg-01"
  location = local.location

  tags = local.tags
}