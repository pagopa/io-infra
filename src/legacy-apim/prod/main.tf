terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.116.0"
    }

    azapi = {
      source  = "azure/azapi"
      version = "<= 1.9.0"
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

provider "azurerm" {
  alias           = "prod-trial"
  subscription_id = "a2124115-ba74-462f-832a-9192cbd03649"

  features {}
}
