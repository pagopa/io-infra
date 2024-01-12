module "subnet_runner" {
  source = "github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.39.0"

  name                 = "${local.project}-github-runner-snet"
  resource_group_name  = data.azurerm_resource_group.rg_common.name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name

  address_prefixes = [
    "${var.networking.subnet_cidr_block}"
  ]

  service_endpoints = [
    "Microsoft.Web"
  ]

  private_endpoint_network_policies_enabled = true
}

module "container_app_environment_runner" {
  source = "github.com/pagopa/terraform-azurerm-v3.git//container_app_environment_v2?ref=EC-79-refactoring-modulo-tf-container-app-environment"

  resource_group_name = azurerm_resource_group.github_runner.name
  location            = azurerm_resource_group.github_runner.location
  name                = "${local.project}-github-runner-cae"

  subnet_id              = module.subnet_runner.id
  internal_load_balancer = true
  zone_redundant         = true

  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.law_common.id

  tags = var.tags
}

module "container_app_jobs" {
  source = "github.com/pagopa/terraform-azurerm-v3.git//container_app_job_gh_runner?ref=EC-81-refactoring-modulo-tf-container-app-job"

  location  = var.location
  prefix    = var.prefix
  env_short = var.env_short

  key_vault = {
    resource_group_name = data.azurerm_resource_group.rg_common.name
    name                = data.azurerm_key_vault.key_vault_common.name
    secret_name         = var.key_vault_common.pat_secret_name
  }

  environment = {
    name                = module.container_app_environment_runner.name
    resource_group_name = module.container_app_environment_runner.resource_group_name
  }

  job = {
    name                 = "infra"
    repo_owner           = "pagopa"
    repo                 = "io-infra"
    polling_interval     = 20
    scale_max_executions = 5
  }

  tags = var.tags
}

# module "github_runner" {
#   source = "github.com/pagopa/terraform-azurerm-v3.git//container_app_job_gh_runner?ref=runner-name"

#   location  = var.location
#   prefix    = var.prefix
#   env_short = var.env_short

#   environment_enumeration = "02"
#   app_enumeration         = "03"

#   key_vault = {
#     resource_group_name = data.azurerm_resource_group.rg_common.name
#     name                = data.azurerm_key_vault.key_vault_common.name
#     secret_name         = var.github_runner.pat_secret_name
#   }

#   network = {
#     vnet_resource_group_name = data.azurerm_resource_group.rg_common.name
#     vnet_name                = data.azurerm_virtual_network.vnet_common.name
#     subnet_cidr_block        = var.github_runner.subnet_cidr_block
#   }

#   environment = {
#     law_resource_group_name = data.azurerm_resource_group.rg_common.name
#     law_name                = data.azurerm_log_analytics_workspace.law_common.name
#   }

#   app = {
#     containers = [
#       {
#         repo   = "io-infra",
#         cpu    = 0.5,
#         memory = "1Gi"
#       },
#       {
#         repo   = "io-sign",
#         cpu    = 0.5,
#         memory = "1Gi"
#       },
#       {
#         repo   = "io-services-cms",
#         cpu    = 0.5,
#         memory = "1Gi"
#       }
#     ]
#   }

#   tags = var.tags
# }
