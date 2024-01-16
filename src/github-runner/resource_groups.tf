resource "azurerm_resource_group" "rg_github_runner" {
  name     = "${local.project}-github-runner-rg"
  location = var.location

  tags = var.tags
}
