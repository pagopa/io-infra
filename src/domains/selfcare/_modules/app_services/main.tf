terraform {

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}
