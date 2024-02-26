terraform {

  backend "azurerm" {
    resource_group_name  = "dev-andreag"
    storage_account_name = "tfproddotnet"
    container_name       = "terraform-state"
    key                  = "terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.92.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}
