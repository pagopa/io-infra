data "azurerm_resource_group" "rg_cgn" {
  name = format("%s-rg-cgn", local.project)
}

data "azurerm_storage_account" "iopstcgn" {
  name                = "iopstcgn"
  resource_group_name = data.azurerm_resource_group.rg_cgn.name
}

## redis cgn subnet
module "redis_cgn_snet" {
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.61.0"
  name                                      = format("%s-redis-cgn-snet", local.project)
  address_prefixes                          = ["10.0.14.0/25"]
  resource_group_name                       = azurerm_resource_group.rg_common.name
  virtual_network_name                      = module.vnet_common.name
  private_endpoint_network_policies_enabled = false
}

module "redis_cgn" {
  source                = "git::https://github.com/pagopa/terraform-azurerm-v3.git//redis_cache?ref=v7.61.0"
  name                  = format("%s-redis-cgn-std", local.project)
  resource_group_name   = data.azurerm_resource_group.rg_cgn.name
  location              = data.azurerm_resource_group.rg_cgn.location
  capacity              = 1
  family                = "C"
  sku_name              = "Standard"
  enable_authentication = true
  zones                 = null
  redis_version         = "6"

  // when azure can apply patch?
  patch_schedules = [{
    day_of_week    = "Sunday"
    start_hour_utc = 23
    },
    {
      day_of_week    = "Monday"
      start_hour_utc = 23
    },
    {
      day_of_week    = "Tuesday"
      start_hour_utc = 23
    },
    {
      day_of_week    = "Wednesday"
      start_hour_utc = 23
    },
    {
      day_of_week    = "Thursday"
      start_hour_utc = 23
    },
  ]

  private_endpoint = {
    enabled              = true
    virtual_network_id   = module.vnet_common.id
    subnet_id            = module.redis_cgn_snet.id
    private_dns_zone_ids = [azurerm_private_dns_zone.privatelink_redis_cache.id]
  }

  tags = var.tags
}

##################
## CosmosDB cgn ##
##################

module "cosmos_cgn" {
  source   = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_account?ref=v7.61.0"
  name     = format("%s-cosmos-cgn", local.project)
  location = var.location
  domain   = "CGN"

  resource_group_name = data.azurerm_resource_group.rg_cgn.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  main_geo_location_zone_redundant = false

  enable_free_tier          = false
  enable_automatic_failover = true


  consistency_policy = {
    consistency_level       = "Strong"
    max_interval_in_seconds = null
    max_staleness_prefix    = null
  }

  main_geo_location_location = "westeurope"

  additional_geo_locations = [
    {
      location          = "northeurope"
      failover_priority = 1
      zone_redundant    = true
    }
  ]

  backup_continuous_enabled = true

  is_virtual_network_filter_enabled = true

  ip_range = ""

  # private endpoint
  private_endpoint_sql_name           = format("%s-cosmos-cgn-sql-endpoint", local.project)
  private_endpoint_enabled            = true
  private_service_connection_sql_name = format("%s-cosmos-cgn-sql-endpoint", local.project)
  subnet_id                           = module.private_endpoints_subnet.id
  private_dns_zone_sql_ids            = [azurerm_private_dns_zone.privatelink_documents.id]

  tags = var.tags

}

## Database
module "cgn_cosmos_db" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_database?ref=v7.61.0"
  name                = "db"
  resource_group_name = data.azurerm_resource_group.rg_cgn.name
  account_name        = module.cosmos_cgn.name
}

### Containers
locals {
  cgn_cosmosdb_containers = [
    {
      name               = "user-cgns"
      partition_key_path = "/fiscalCode"
      autoscale_settings = {
        max_throughput = 1000
      },
    },
    {
      name               = "user-eyca-cards"
      partition_key_path = "/fiscalCode"
      autoscale_settings = {
        max_throughput = 1000
      },
    },
  ]
}

module "cgn_cosmosdb_containers" {
  source   = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_container?ref=v7.61.0"
  for_each = { for c in local.cgn_cosmosdb_containers : c.name => c }

  name                = each.value.name
  resource_group_name = data.azurerm_resource_group.rg_cgn.name
  account_name        = module.cosmos_cgn.name
  database_name       = module.cgn_cosmos_db.name
  partition_key_path  = each.value.partition_key_path
  throughput          = lookup(each.value, "throughput", null)

  autoscale_settings = lookup(each.value, "autoscale_settings", null)
}


## Blob storage due to legal backup
#tfsec:ignore:azure-storage-default-action-deny
#tfsec:ignore:azure-storage-queue-services-logging-enabled:exp:2022-05-01 # already ignored, maybe a bug in tfsec
module "cgn_legalbackup_storage" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v7.61.0"

  name                            = replace(format("%s-cgn-legalbackup-storage", local.project), "-", "")
  account_kind                    = "StorageV2"
  account_tier                    = "Standard"
  access_tier                     = "Hot"
  blob_versioning_enabled         = var.cgn_legalbackup_enable_versioning
  account_replication_type        = var.cgn_legalbackup_account_replication_type
  resource_group_name             = data.azurerm_resource_group.rg_cgn.name
  location                        = data.azurerm_resource_group.rg_cgn.location
  advanced_threat_protection      = false
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = true

  tags = var.tags
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry
resource "azurerm_key_vault_secret" "cgn_legalbackup_storage_access_key" {
  name         = "cgn-legalbackup-storage-access-key"
  value        = module.cgn_legalbackup_storage.primary_access_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry
resource "azurerm_key_vault_secret" "cgn_legalbackup_storage_connection_string" {
  name         = "cgn-legalbackup-storage-connection-string"
  value        = module.cgn_legalbackup_storage.primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault_common.id
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry
resource "azurerm_key_vault_secret" "cgn_legalbackup_storage_blob_connection_string" {
  name         = "cgn-legalbackup-storage-blob-connection-string"
  value        = module.cgn_legalbackup_storage.primary_blob_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault_common.id
}

resource "azurerm_storage_container" "cgn_legalbackup_container" {
  name                  = "cgn-legalbackup-blob"
  storage_account_name  = module.cgn_legalbackup_storage.name
  container_access_type = "private"
}

resource "azurerm_private_endpoint" "cgn_legalbackup_storage" {
  name                = format("%s-cgn-legalbackup-storage", local.project)
  location            = data.azurerm_resource_group.rg_cgn.location
  resource_group_name = data.azurerm_resource_group.rg_cgn.name
  subnet_id           = module.private_endpoints_subnet.id

  private_service_connection {
    name                           = format("%s-cgn-legalbackup-storage-private-endpoint", local.project)
    private_connection_resource_id = module.cgn_legalbackup_storage.id
    is_manual_connection           = false
    subresource_names              = ["Blob"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.privatelink_blob_core.id]
  }
}

locals {
  cgn_app_registreation_name = "cgn-onboarding-portal-backend"
}

### cgnonboardingportal user identity
data "azurerm_key_vault_secret" "cgn_onboarding_backend_identity" {
  name         = "cgn-onboarding-backend-PRINCIPALID"
  key_vault_id = module.key_vault_common.id
}

# TODO rollback after apim-v2 migration
# resource "azurerm_role_assignment" "service_contributor" {
#   count                = var.env_short == "p" ? 1 : 0
#   scope                = module.apim.id
#   role_definition_name = "API Management Service Contributor"
#   principal_id         = data.azurerm_key_vault_secret.cgn_onboarding_backend_identity.value
# }

resource "azurerm_resource_group" "cgn_be_rg" {
  name     = format("%s-cgn-be-rg", local.project)
  location = var.location
}

resource "azurerm_app_service_plan" "cgn_common" {
  name                = format("%s-plan-cgn-common", local.project)
  location            = azurerm_resource_group.cgn_be_rg.location
  resource_group_name = azurerm_resource_group.cgn_be_rg.name

  kind     = var.plan_cgn_kind
  reserved = true

  sku {
    tier     = var.plan_cgn_sku_tier
    size     = var.plan_cgn_sku_size
    capacity = var.plan_cgn_sku_capacity
  }

  tags = var.tags
}

# Subnet to host app function
module "cgn_snet" {
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.61.0"
  name                                      = format("%s-cgn-snet", local.project)
  address_prefixes                          = var.cidr_subnet_cgn
  resource_group_name                       = azurerm_resource_group.rg_common.name
  virtual_network_name                      = module.vnet_common.name
  private_endpoint_network_policies_enabled = false

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage",
  ]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet_nat_gateway_association" "cgn_snet" {
  nat_gateway_id = module.nat_gateway.id
  subnet_id      = module.cgn_snet.id
}
