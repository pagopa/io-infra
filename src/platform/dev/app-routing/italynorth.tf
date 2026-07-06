resource "azurerm_resource_group" "apim" {
  name     = "${local.project}-apim-rg-01"
  location = local.location

  tags = local.tags
}