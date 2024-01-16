module "container_app_environment_runner" {
  source = "github.com/pagopa/terraform-azurerm-v3.git//container_app_environment_v2?ref=v7.46.0"

  resource_group_name = azurerm_resource_group.rg_github_runner.name
  location            = azurerm_resource_group.rg_github_runner.location
  name                = "${local.project}-github-runner-cae"

  subnet_id              = module.subnet_runner.id
  internal_load_balancer = true
  zone_redundant         = false

  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.law_common.id

  tags = var.tags
}

resource "azurerm_management_lock" "lock_cae" {
  lock_level = "CanNotDelete"
  name       = "${local.project}-github-runner-cae"
  notes      = "This Container App Environment cannot be deleted"
  scope      = module.container_app_environment_runner.id
}
