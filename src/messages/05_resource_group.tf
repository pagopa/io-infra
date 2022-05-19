resource "azurerm_resource_group" "data_process_rg" {
  name     = "${local.project}-data-process-rg"
  location = var.location

  tags = var.tags
}
