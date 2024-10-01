# CGN PostgreSQL Single Server

data "azurerm_postgresql_server" "cgn_psql" {
  provider            = azurerm.prod-cgn
  name                = "cgnonboardingportal-p-db-postgresql"
  resource_group_name = "cgnonboardingportal-p-db-rg"
}