terraform {

  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "iopitntfst001"
    container_name       = "terraform-state"
    key                  = "io-infra.core.prod.italynorth.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.101.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "vnet" {
  name     = "${local.project}-common-rg-01"
  location = local.location

  tags = local.tags
}

module "networking" {
  source = "../_modules/networking"

  location            = azurerm_resource_group.vnet.location
  resource_group_name = azurerm_resource_group.vnet.name
  project             = local.project

  vnet_cidr_block = local.vnet_cidr_block
  pep_snet_cidr   = local.pep_snet_cidr

  tags = local.tags
}
