resource "azurerm_service_plan" "selfcare_be_common" {
  name                = "${var.project}-plan-selfcare-be-common"
  location            = var.location
  resource_group_name = var.resource_group_name

  os_type      = "Linux"
  sku_name     = "P1v3"
  worker_count = null

  tags = var.tags
}
