resource "azurerm_resource_group" "github_runner" {
  name     = "${local.project_itn}-github-runner-rg-01"
  location = "italynorth"

  tags = local.tags
}

module "github_runner_itn" {
  source = "../_modules/github_runner"

  project             = local.project_itn
  location            = azurerm_resource_group.github_runner.location
  resource_group_name = azurerm_resource_group.github_runner.name

  vnet_common = local.core.networking.itn.vnet_common

  cidr_subnet = "10.20.14.0/23"

  log_analytics_workspace_id = module.monitoring_weu.log.id

  tags = local.tags
}

module "private_endpoints_itn" {
  source = "../_modules/private_endpoint"

  project             = local.project_itn
  location            = "italynorth"
  resource_group_name = local.resource_groups.itn.common

  vnet_common = local.core.networking.itn.vnet_common
  pep_snet_id = data.azurerm_subnet.itn_pep_snet.id

  tags = local.tags
}