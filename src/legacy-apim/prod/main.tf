terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.13.0"
    }

    azapi = {
      source  = "azure/azapi"
      version = "~> 2.13.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "iopitntfst001"
    container_name       = "terraform-state"
    key                  = "io-infra.legacy-apim.tfstate"
  }
}

provider "azurerm" {
  features {}
}

provider "azapi" {
}
