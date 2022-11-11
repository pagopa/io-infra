module "cosmosdb_account" {
  source                           = "git::https://github.com/pagopa/azurerm.git//cosmosdb_account?ref=v2.13.1"
  name                             = format("%s-cosmos", local.project)
  location                         = azurerm_resource_group.data_rg.location
  resource_group_name              = azurerm_resource_group.data_rg.name
  kind                             = "GlobalDocumentDB"
  main_geo_location_location       = azurerm_resource_group.data_rg.location
  main_geo_location_zone_redundant = false

  public_network_access_enabled = false

  is_virtual_network_filter_enabled = true

  private_endpoint_enabled = true
  subnet_id                = data.azurerm_subnet.private_endpoints_subnet.id
  private_dns_zone_ids     = [data.azurerm_private_dns_zone.privatelink_documents_azure_com.id]

  tags = var.tags
}
