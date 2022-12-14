module "cosmosdb_account" {
  source                           = "git::https://github.com/pagopa/azurerm.git//cosmosdb_account?ref=v2.15.1"
  name                             = format("%s-cosmos", local.project)
  location                         = azurerm_resource_group.data_rg.location
  resource_group_name              = azurerm_resource_group.data_rg.name
  kind                             = "GlobalDocumentDB"
  main_geo_location_location       = azurerm_resource_group.data_rg.location
  main_geo_location_zone_redundant = var.cosmos.zone_redundant

  # TODO Temporarely disabled due to Azure Resouces not available in North EU
  # additional_geo_locations = [
  #   {
  #     location          = "northeurope"
  #     failover_priority = 1
  #     zone_redundant    = true
  #   }
  # ]

  # Having multiple region requires
  # maximum lag must be between 5 minutes and 1 day
  # and between 100000 operations and 1000000 operations
  consistency_policy = {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }

  public_network_access_enabled = false

  is_virtual_network_filter_enabled = true

  private_endpoint_enabled = true
  subnet_id                = data.azurerm_subnet.private_endpoints_subnet.id
  private_dns_zone_ids     = [data.azurerm_private_dns_zone.privatelink_documents_azure_com.id]

  tags = var.tags
}
