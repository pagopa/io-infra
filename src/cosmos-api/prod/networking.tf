resource "azurerm_private_endpoint" "sql" {

  name                = "${azurerm_cosmosdb_account.this.name}-sql-endpoint"
  location            = azurerm_cosmosdb_account.this.location
  resource_group_name = azurerm_cosmosdb_account.this.resource_group_name
  subnet_id           = data.azurerm_subnet.pep.id

  private_service_connection {
    name                           = "${azurerm_cosmosdb_account.this.name}-sql"
    private_connection_resource_id = azurerm_cosmosdb_account.this.id
    is_manual_connection           = false
    subresource_names              = ["Sql"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.documents.id]
  }

  tags = local.tags
}
