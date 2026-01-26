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

resource "azurerm_resource_group" "itn_elt" {
  name     = format("%s-elt-rg-01", local.project_itn)
  location = local.location_itn

  tags = local.tags
}

module "storage_accounts" {
  source = "../_modules/storage_accounts"

  project                 = local.project
  project_itn             = local.project_itn
  location                = local.location
  location_itn            = local.location_itn
  resource_group_name_itn = azurerm_resource_group.itn_elt.name

  tags = local.tags
}