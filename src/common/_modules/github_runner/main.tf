resource "azurerm_subnet" "github_runner" {
  name                 = "${var.project}-github-runner-snet-01"
  resource_group_name  = var.vnet_common.resource_group_name
  virtual_network_name = var.vnet_common.name
  address_prefixes     = [var.cidr_subnet]

  service_endpoints = [
    "Microsoft.Web"
  ]

  private_endpoint_network_policies = "Enabled"
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

module "container_app_github_runner" {
  source  = "pagopa-dx/github-selfhosted-runner-on-container-app-jobs/azurerm"
  version = "~> 1.0"

  environment = {
    prefix          = var.prefix
    env_short       = var.env_short
    location        = azurerm_container_app_environment.github_runner.location
    instance_number = "01"
  }

  resource_group_name = var.resource_group_name

  container_app_environment = {
    id                          = azurerm_container_app_environment.github_runner.id
    location                    = azurerm_container_app_environment.github_runner.location
    replica_timeout_in_seconds  = 10800
    polling_interval_in_seconds = 20
    cpu                         = 1
    memory                      = "2Gi"
  }

  key_vault = {
    name                = var.key_vault_pat_token.name
    resource_group_name = var.key_vault_pat_token.resource_group_name
  }

  repository = {
    name = "io-infra"
  }

  tags = var.tags
}
