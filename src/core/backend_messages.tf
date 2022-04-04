resource "azurerm_resource_group" "backend_messages_rg" {
  name     = format("%s-backend-messages-rg", local.project)
  location = var.location

  tags = var.tags
}
