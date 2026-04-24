resource "azurerm_cdn_frontdoor_profile" "common_cdn" {
  name                     = "${var.prefix}-${var.env_short}-cdn-common"
  resource_group_name      = var.resource_group_cdn
  sku_name                 = "Standard_AzureFrontDoor"
  response_timeout_seconds = 30
  tags                     = var.tags
}