terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.107.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "tfinfprodio"
    container_name       = "terraform-state"
    key                  = "io-infra.notification-hubs.tfstate"
  }
}

provider "azurerm" {
  features {
  }
}

resource "azurerm_resource_group" "notifications" {
  name     = "${local.legacy_project}-rg-notifications"
  location = local.legacy_location

  tags = local.tags
}
