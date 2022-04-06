resource "azurerm_resource_group" "cluster_rg" {
  name     = "${local.project}-cluster-rg"
  location = var.location

  tags = var.tags
}
