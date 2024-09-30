locals {
  private_endpoints = {
    "cgn-psql" = {
      resource_id         = data.azurerm_postgresql_server.cgn_psql.id
      subresource_names   = ["postgresqlServer"]
      private_dns_zone_id = data.azurerm_private_dns_zone.cgn_psql_private_dns_zone.id
    }
  }
}