terraform {

  # backend "azurerm" {
  #   resource_group_name  = "terraform-state-rg"
  #   storage_account_name = "iopitntfst001"
  #   container_name       = "terraform-state"
  #   key                  = "io-infra.migration.prod.italynorth.tfstate"
  # }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.116.0"
    }

    azapi = {
      source  = "Azure/azapi"
      version = "<= 1.15.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azapi" {}
