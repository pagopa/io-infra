resource "azurerm_resource_group" "github_runner" {
  name     = "${local.project}-github-runner-rg"
  location = var.location

  tags = var.tags
}

resource "azurerm_subnet" "github_runner" {
  name                 = "${local.project}-github-runner-snet"
  resource_group_name  = azurerm_resource_group.rg_common.name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name
  address_prefixes     = ["10.0.242.0/23"]
}

module "github_runner" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//container_app_environment?ref=v4.1.18"

  name                      = "${local.project}-github-runner-cae"
  resource_group_name       = azurerm_resource_group.github_runner.name
  location                  = var.location
  vnet_internal             = true
  subnet_id                 = azurerm_subnet.github_runner.id
  log_destination           = "log-analytics"
  log_analytics_customer_id = data.azurerm_log_analytics_workspace.log_analytics_workspace.workspace_id
  log_analytics_shared_key  = data.azurerm_log_analytics_workspace.log_analytics_workspace.primary_shared_key
  zone_redundant            = true

  tags = var.tags
}
