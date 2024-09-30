# CGN PostgreSQL Single Server

data "azurerm_private_dns_zone" "cgn_psql_private_dns_zone" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = "io-p-rg-common"
}

data "azurerm_postgresql_server" "cgn_psql" {
  provider            = azurerm.uat-cgn
  name                = "cgnonboardingportal-u-db-postgresql"
  resource_group_name = "cgnonboardingportal-u-db-rg"
}