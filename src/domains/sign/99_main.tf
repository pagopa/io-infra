terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 2.98.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "= 2.16.0"
    }
  }

  backend "azurerm" {}

  required_version = ">= 1.1.7"
}

provider "azurerm" {
  features {}
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}
