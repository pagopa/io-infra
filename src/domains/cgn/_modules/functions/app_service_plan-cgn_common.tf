resource "azurerm_app_service_plan" "cgn_common" {
  name                = format("%s-plan-cgn-common", var.project)
  location            = var.location
  resource_group_name = var.resource_group_name

  kind     = "Linux"
  reserved = true

  sku {
    tier     = "PremiumV3"
    size     = "P1v3"
    capacity = 1
  }

  tags = var.tags
}
