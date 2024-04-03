resource "azurerm_service_plan" "continua" {
  name                = format("%s-app-continua", var.project)
  resource_group_name = var.resource_group_name
  location            = var.location

  os_type                = "Linux"
  sku_name               = "P1v3"
  zone_balancing_enabled = true

  tags = var.tags
}
