resource "azurerm_cosmosdb_account" "this" {
  name                = "${var.project}-cosmos-api"
  resource_group_name = var.resource_groups.internal
  location            = var.location

  offer_type        = "Standard"
  free_tier_enabled = false

  automatic_failover_enabled = true
  ip_range_filter            = join(",", local.ip_range_filter)

  geo_location {
    location          = var.location
    failover_priority = 0
    zone_redundant    = true
  }

  dynamic "geo_location" {
    for_each = var.secondary_location != null ? [var.secondary_location] : []
    content {
      location          = geo_location.value
      failover_priority = 1
      zone_redundant    = false
    }
  }

  consistency_policy {
    consistency_level = "Strong" # TODO: Consider returning to BoundedSession
  }

  public_network_access_enabled     = true
  is_virtual_network_filter_enabled = true

  dynamic "virtual_network_rule" {
    for_each = var.allowed_subnets_ids

    content {
      id = virtual_network_rule.value
    }
  }

  tags = var.tags
}
