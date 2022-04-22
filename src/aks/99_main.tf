terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 2.99.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "= 2.21.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "= 3.1.1"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}
