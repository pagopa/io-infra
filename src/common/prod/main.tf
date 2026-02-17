terraform {

  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "iopitntfst001"
    container_name       = "terraform-state"
    key                  = "io-infra.common.prod.tfstate"
    use_azuread_auth     = true
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 4.36.0"
    }
    dx = {
      source  = "pagopa-dx/azure"
      version = "~> 0.4"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~> 2.7"
    }
  }
}

provider "azurerm" {
  features {}
  storage_use_azuread = true
}

provider "dx" {}

provider "azapi" {}
