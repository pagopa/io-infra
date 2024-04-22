module "cosmos_account_cgn" {
  source = "github.com/pagopa/terraform-azurerm-v3//cosmosdb_account?ref=v7.69.1"

  name                = "${var.project}-cosmos-cgn"
  resource_group_name = var.resource_group_name
  location            = var.location
  domain              = "CGN"

  offer_type = "Standard"
  kind       = "GlobalDocumentDB"

  main_geo_location_zone_redundant = false

  enable_free_tier          = false
  enable_automatic_failover = true

  consistency_policy = {
    consistency_level       = "Strong"
    max_interval_in_seconds = null
    max_staleness_prefix    = null
  }

  main_geo_location_location = var.location

  additional_geo_locations = [
    {
      location          = var.secondary_location
      failover_priority = 1
      zone_redundant    = true
    }
  ]

  backup_continuous_enabled = true

  is_virtual_network_filter_enabled = true

  ip_range = ""

  # private endpoint
  private_endpoint_sql_name           = "${var.project}-cosmos-cgn-sql-endpoint"
  private_endpoint_enabled            = true
  private_service_connection_sql_name = "${var.project}-cosmos-cgn-sql-endpoint"
  subnet_id                           = var.private_endpoint_subnet_id
  private_dns_zone_sql_ids            = [data.azurerm_private_dns_zone.privatelink_documents.id]

  tags = var.tags
}
