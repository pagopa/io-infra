module "event_hubs_weu" {
  source = "./_modules/event_hubs"

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
  source = "./_modules/cosmos_api"

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

resource "azurerm_key_vault_secret" "cosmos_api_connection_string" {
  name         = "cosmos-api-connection-string"
  key_vault_id = local.core.key_vault.weu.kv_common.id
  value        = module.cosmos_api_weu.connection_string

  tags = local.tags
}

resource "azurerm_key_vault_secret" "cosmos_api_primary_key" {
  name         = "cosmos-api-primary-key"
  key_vault_id = local.core.key_vault.weu.kv_common.id
  value        = module.cosmos_api_weu.primary_key

  tags = local.tags
}

module "redis_weu" {
  source = "./_modules/redis"

  location       = "westeurope"
  location_short = local.core.resource_groups.westeurope.location_short
  project        = local.project_weu_legacy

  resource_group_common    = local.core.resource_groups.westeurope.common
  vnet_common              = local.core.networking.weu.vnet_common
  cidr_subnet_redis_common = "10.0.200.0/24"

  tags = local.tags
}