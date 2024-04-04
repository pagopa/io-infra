terraform {

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

data "azurerm_subscription" "current" {}
