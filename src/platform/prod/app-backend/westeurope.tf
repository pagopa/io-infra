module "app_backend_weu" {
  for_each = local.app_backends
  source   = "./_modules/app_backend"

  location                = "westeurope"
  location_short          = local.core.resource_groups.westeurope.location_short
  project                 = local.project_weu_legacy
  prefix                  = local.prefix
  resource_group_linux    = local.core.resource_groups.westeurope.linux
  resource_group_internal = local.core.resource_groups.westeurope.internal
  resource_group_common   = local.core.resource_groups.westeurope.common

  datasources = {
    azurerm_client_config = data.azurerm_client_config.current
  }

  name  = "l${each.key}"
  index = each.key

  vnet_common                   = local.core.networking.weu.vnet_common
  subnet_pep_id                 = local.core.networking.weu.pep_snet.id
  private_dns_zone_id           = local.platform_core.dns.zones.private_dns_zones.appservice.id
  cidr_subnet                   = each.value.cidr_subnet
  nat_gateways                  = local.core.networking.weu.nat_gateways
  allowed_subnets               = []
  slot_allowed_subnets          = [module.github_runner_itn.subnet.id]
  allowed_ips                   = local.platform_observability.monitoring_westeurope.appi.reserved_ips
  slot_allowed_ips              = local.platform_observability.monitoring_westeurope.appi.reserved_ips
  enable_premium_plan_autoscale = true

  plan_sku = "P2v3"

  backend_hostnames = local.backend_hostnames

  key_vault        = local.core.key_vault.weu.kv
  key_vault_common = local.core.key_vault.weu.kv_common

  error_action_group_id  = local.platform_observability.monitoring_westeurope.action_groups.error
  application_insights   = local.platform_observability.monitoring_westeurope.appi
  ai_instrumentation_key = sensitive(local.platform_observability.monitoring_westeurope.appi_instrumentation_key)
  ai_connection_string   = sensitive(local.platform_observability.monitoring_westeurope.appi_connection_string)

  redis_common = {
    hostname           = module.redis_weu.hostname
    ssl_port           = module.redis_weu.ssl_port
    primary_access_key = module.redis_weu.primary_access_key
  }

  azure_adgroup_wallet_admins_object_id = data.azuread_group.wallet_admins.object_id
  azure_adgroup_com_admins_object_id    = data.azuread_group.com_admins.object_id
  azure_adgroup_svc_admins_object_id    = data.azuread_group.svc_admins.object_id
  azure_adgroup_auth_admins_object_id   = data.azuread_group.auth_admins.object_id
  azure_adgroup_bonus_admins_object_id  = data.azuread_group.bonus_admins.object_id

  tags = local.tags
}