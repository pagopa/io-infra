data "azurerm_subscription" "trial_system" {
  provider = azurerm.prod-trial
}

data "azurerm_subscription" "cgn" {
  provider = azurerm.prod-cgn
}

data "azurerm_postgresql_server" "cgn_psql" {
  provider            = azurerm.prod-cgn
  name                = "cgnonboardingportal-p-db-postgresql"
  resource_group_name = "cgnonboardingportal-p-db-rg"
}