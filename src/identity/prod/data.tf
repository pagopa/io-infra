data "azurerm_subscription" "trial_system" {
  provider = azurerm.prod-trial
}

data "azurerm_subscription" "cgn" {
  provider = azurerm.prod-cgn
}