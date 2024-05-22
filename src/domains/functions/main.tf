terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.100.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "<= 2.33.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}