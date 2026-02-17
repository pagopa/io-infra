module "cosmos_account_cgn" {
  source = "github.com/pagopa/terraform-azurerm-v3//cosmosdb_account?ref=v7.69.1"

  name                = "${var.project}-cosmos-cgn"
  resource_group_name = var.resource_group_name
  location            = var.location
  domain              = "CGN"

  offer_type = "Standard"
  kind       = "GlobalDocumentDB"

  main_geo_location_zone_redundant = true

  enable_free_tier          = false
  enable_automatic_failover = true

  consistency_policy = {
    consistency_level       = "Strong"
    max_interval_in_seconds = null
    max_staleness_prefix    = null
  }

  main_geo_location_location = var.secondary_locations[0]

  additional_geo_locations = [
    {
      location          = var.secondary_locations[1]
      failover_priority = 1
      zone_redundant    = false
    }
  ]

  backup_continuous_enabled = true

  is_virtual_network_filter_enabled = true

  ip_range = ""

  private_endpoint_enabled = false

  tags = var.tags
}

resource "azurerm_private_endpoint" "cosno_remote_content_itn" {
  name                = "${var.project}-itn-cgn-cosno-pep-01"
  location            = "italynorth"
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id_itn

  private_service_connection {
    name                           = "${var.project}-itn-cgn-cosno-pep-01"
    private_connection_resource_id = module.cosmos_account_cgn.id
    is_manual_connection           = false
    subresource_names              = ["Sql"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_documents.id]
  }

  tags = var.tags
}
