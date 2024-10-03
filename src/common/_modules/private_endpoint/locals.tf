locals {
  private_endpoints = {
    "cgn-psql" = {
      "01" = {
        resource_id         = data.azurerm_postgresql_server.cgn_psql.id
        subresource_names   = ["postgresqlServer"]
        private_dns_zone_id = var.dns_zones.postgres.id
      }
    }
  }
}