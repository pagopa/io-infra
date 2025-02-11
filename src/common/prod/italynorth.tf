resource "azurerm_resource_group" "github_runner" {
  name     = "${local.project_itn}-github-runner-rg-01"
  location = "italynorth"

  tags = local.tags
}

module "github_runner_itn" {
  source = "../_modules/github_runner"

  project             = local.project_itn
  location            = "italynorth"
  resource_group_name = azurerm_resource_group.github_runner.name

  vnet_common = local.core.networking.itn.vnet_common

  cidr_subnet = "10.20.14.0/23"

  log_analytics_workspace_id = module.monitoring_weu.log.id

  tags = local.tags
}

module "private_endpoints" {
  source = "../_modules/private_endpoint"

  project             = local.project_itn
  location            = "italynorth"
  resource_group_name = local.resource_groups.itn.common

  pep_snet_id = local.core.networking.itn.pep_snet.id
  dns_zones   = module.global.dns.private_dns_zones

  tags = local.tags
}

module "apim_itn" {
  source = "../_modules/apim"

  migration               = true
  location                = "italynorth"
  location_short          = local.core.resource_groups.italynorth.location_short
  project                 = local.project_itn
  prefix                  = local.prefix
  resource_group_common   = local.resource_groups.itn.common
  resource_group_internal = local.resource_groups.itn.internal

  vnet_common = local.core.networking.itn.vnet_common
  cidr_subnet = "10.20.100.0/24"

  datasources = {
    azurerm_client_config = data.azurerm_client_config.current
  }

  key_vault        = local.core.key_vault.weu.kv
  key_vault_common = local.core.key_vault.weu.kv_common

  action_group_id        = module.monitoring_weu.action_groups.error
  ai_instrumentation_key = module.monitoring_weu.appi_instrumentation_key

  azure_adgroup_wallet_admins_object_id = data.azuread_group.wallet_admins.object_id
  azure_adgroup_com_admins_object_id    = data.azuread_group.com_admins.object_id
  azure_adgroup_svc_admins_object_id    = data.azuread_group.svc_admins.object_id
  azure_adgroup_auth_admins_object_id   = data.azuread_group.auth_admins.object_id
  azure_adgroup_bonus_admins_object_id  = data.azuread_group.bonus_admins.object_id

  tags = local.tags
}
