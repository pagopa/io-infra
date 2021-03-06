terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 2.87.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "= 2.16.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

data "terraform_remote_state" "core" {
  backend = "azurerm"

  config = {
    resource_group_name  = var.terraform_remote_state_core.resource_group_name
    storage_account_name = var.terraform_remote_state_core.storage_account_name
    container_name       = var.terraform_remote_state_core.container_name
    key                  = var.terraform_remote_state_core.key
  }
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}
