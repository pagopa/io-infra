resource "azurerm_subnet" "github_runner" {
  name                 = "${var.project}-github-runner-snet-01"
  resource_group_name  = var.vnet_common.resource_group_name
  virtual_network_name = var.vnet_common.name
  address_prefixes     = [var.cidr_subnet]

  service_endpoints = [
    "Microsoft.Web"
  ]

  private_endpoint_network_policies_enabled = true
}

resource "azurerm_container_app_environment" "github_runner" {
  name                = "${var.project}-github-runner-cae-01"
  location            = var.location
  resource_group_name = var.resource_group_name

  log_analytics_workspace_id = var.log_analytics_workspace_id

  infrastructure_subnet_id       = azurerm_subnet.github_runner.id
  zone_redundancy_enabled        = false
  internal_load_balancer_enabled = true

  tags = var.tags
}
