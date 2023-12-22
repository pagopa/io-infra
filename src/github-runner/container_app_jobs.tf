module "github_runner" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//container_app_job_gh_runner?ref=v7.35.0"

  location  = var.location
  prefix    = var.prefix
  env_short = var.env_short

  key_vault = {
    resource_group_name = data.azurerm_resource_group.rg_common.name
    name                = data.azurerm_key_vault.key_vault_common.name
    secret_name         = var.github_runner.pat_secret_name
  }

  network = {
    vnet_resource_group_name = data.azurerm_resource_group.rg_common.name
    vnet_name                = data.azurerm_virtual_network.vnet_common.name
    subnet_cidr_block        = var.github_runner.subnet_cidr_block
  }

  environment = {
    law_resource_group_name = data.azurerm_resource_group.rg_common.name
    law_name                = data.azurerm_log_analytics_workspace.law_common.name
  }

  app = {
    repos = [
      "io-infra",
      "io-sign"
    ]
  }

  tags = var.tags
}
