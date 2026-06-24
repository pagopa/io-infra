module "event_hubs_weu" {
  source = "../_modules/event_hubs"

  location              = "westeurope"
  location_short        = local.core.resource_groups.westeurope.location_short
  project               = local.project_weu_legacy
  resource_group_common = local.core.resource_groups.westeurope.common

  servicebus_dns_zone   = local.platform_core.dns.zones.private_dns_zones.servicebus
  vnet_common           = local.core.networking.weu.vnet_common
  key_vault             = local.core.key_vault.weu.kv
  error_action_group_id = local.platform_observability.monitoring_westeurope.action_groups.error

  cidr_subnet = ["10.0.10.0/24"]
  sku_name    = "Standard"
  eventhubs   = local.eventhubs
  ip_rules = [
    {
      ip_mask = "18.192.147.151", # PDND
      action  = "Allow"
    },
    {
      ip_mask = "18.159.227.69", # PDND
      action  = "Allow"
    },
    {
      ip_mask = "3.126.198.129", # PDND
      action  = "Allow"
    }
  ]

  tags = local.tags
}

module "cosmos_api_weu" {
  source = "../_modules/cosmos_api"

  location       = "westeurope"
  location_short = local.core.resource_groups.westeurope.location_short
  project        = local.project_weu_legacy

  resource_group_internal        = local.core.resource_groups.westeurope.internal
  vnet_common                    = local.core.networking.weu.vnet_common
  pep_snet                       = local.core.networking.weu.pep_snet
  secondary_location             = "spaincentral"
  secondary_location_pep_snet_id = local.core.networking.itn.pep_snet.id
  documents_dns_zone             = local.platform_core.dns.zones.private_dns_zones.documents
  allowed_subnets_ids            = values(data.azurerm_subnet.cosmos_api_allowed)[*].id

  error_action_group_id = local.platform_observability.monitoring_westeurope.action_groups.error

  azure_adgroup_com_admins_object_id  = data.azuread_group.com_admins.object_id
  azure_adgroup_com_devs_object_id    = data.azuread_group.com_devs.object_id
  azure_adgroup_svc_admins_object_id  = data.azuread_group.svc_admins.object_id
  azure_adgroup_svc_devs_object_id    = data.azuread_group.svc_devs.object_id
  azure_adgroup_auth_admins_object_id = data.azuread_group.auth_admins.object_id
  azure_adgroup_auth_devs_object_id   = data.azuread_group.auth_devs.object_id

  infra_identity_ids = [
    data.azurerm_user_assigned_identity.auth_n_identity_infra_ci.principal_id,
    data.azurerm_user_assigned_identity.auth_n_identity_infra_cd.principal_id,
  ]

  tags = local.tags
}

module "redis_weu" {
  source = "../_modules/redis"

  location       = "westeurope"
  location_short = local.core.resource_groups.westeurope.location_short
  project        = local.project_weu_legacy

  resource_group_common    = local.core.resource_groups.westeurope.common
  vnet_common              = local.core.networking.weu.vnet_common
  cidr_subnet_redis_common = "10.0.200.0/24"

  tags = local.tags
}

module "app_backend_weu" {
  for_each = local.app_backends
  source   = "../_modules/app_backend"

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

module "storage_accounts" {
  source = "../_modules/storage_accounts"

  project                   = local.project_weu_legacy
  subscription_id           = data.azurerm_subscription.current.subscription_id
  location                  = "westeurope"
  resource_group_operations = local.core.resource_groups.westeurope.operations
  resource_group_common     = local.core.resource_groups.italynorth.common

  azure_adgroup_com_admins_object_id = data.azuread_group.com_admins.object_id
  azure_adgroup_com_devs_object_id   = data.azuread_group.com_devs.object_id
  azure_adgroup_admins_object_id     = data.azuread_group.admins.object_id
  azure_adgroup_svc_devs_object_id   = data.azuread_group.svc_devs.object_id

  tags = local.tags
}
