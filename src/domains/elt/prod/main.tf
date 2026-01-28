terraform {

  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "tfinfprodio"
    container_name       = "terraform-state"
    key                  = "io-infra.elt.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.97.1"
    }
  }
}

provider "azurerm" {
  features {}
}


// Resource group removed from state without destroying it in Azure
// It will be managed by the common domain inside fn-elt module
removed {
  from = azurerm_resource_group.itn_elt

  lifecycle {
    destroy = false
  }
}