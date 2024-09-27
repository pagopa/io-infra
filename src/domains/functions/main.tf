terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.116.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "<= 2.53.1"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}