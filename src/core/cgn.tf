data "azurerm_resource_group" "rg_cgn" {
  name = format("%s-rg-cgn", local.project)
}

data "azurerm_storage_account" "iopstcgn" {
  name                = "iopstcgn"
  resource_group_name = data.azurerm_resource_group.rg_cgn.name
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

data "azurerm_resource_group" "cgn_be_rg" {
  name = format("%s-cgn-be-rg", local.project)
}

resource "azurerm_app_service_plan" "cgn_common" {
  name                = format("%s-plan-cgn-common", local.project)
  location            = data.azurerm_resource_group.cgn_be_rg.location
  resource_group_name = data.azurerm_resource_group.cgn_be_rg.name

  kind     = var.plan_cgn_kind
  reserved = true

  sku {
    tier     = var.plan_cgn_sku_tier
    size     = var.plan_cgn_sku_size
    capacity = var.plan_cgn_sku_capacity
  }

  tags = var.tags
}

data "azurerm_subnet" "cgn_snet" {
  name                 = format("%s-cgn-snet", local.project)
  resource_group_name  = azurerm_resource_group.rg_common.name
  virtual_network_name = module.vnet_common.name
}
