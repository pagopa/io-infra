resource "azurerm_cosmosdb_account" "this" {
  name                = "${local.project}-cosmos-api"
  resource_group_name = local.resource_group_name_internal
  location            = local.location

  offer_type        = "Standard"
  free_tier_enabled = false

  automatic_failover_enabled = true

  geo_location {
    location          = local.location
    failover_priority = 0
    zone_redundant    = true
  }

  geo_location {
    location          = local.secondary_location
    failover_priority = 1
    zone_redundant    = false
  }

  consistency_policy {
    consistency_level = "Strong"
  }

  public_network_access_enabled     = true
  is_virtual_network_filter_enabled = true

  virtual_network_rule {
    id = data.azurerm_subnet.fn3admin.id
  }

  virtual_network_rule {
    id = data.azurerm_subnet.fn3app1.id
  }

  virtual_network_rule {
    id = data.azurerm_subnet.fn3app2.id
  }

  virtual_network_rule {
    id = data.azurerm_subnet.fn3appasync.id
  }

  virtual_network_rule {
    id = data.azurerm_subnet.fn3assets.id
  }

  virtual_network_rule {
    id = data.azurerm_subnet.fn3public.id
  }

  virtual_network_rule {
    id = data.azurerm_subnet.fn3services.id
  }

  virtual_network_rule {
    id = data.azurerm_subnet.fn3slackbot.id
  }

  tags = local.tags
}
