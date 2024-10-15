terraform {

  backend "azurerm" {
    resource_group_name   = "dev-fasanorg" 
    storage_account_name  = "stbipdevtest" 
    container_name        = "bc-tf-bip-dev-test" 
    key                   = "terraform.tfstate" 
  }

  required_version = ">= 1.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
  }
}

# Main.tf per l'ambiente DEV
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

data "azurerm_client_config" "current" {}
