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
  location = "italynorth"

  tags = local.tags
}

module "networking" {
  source = "../_modules/networking"

  location            = azurerm_resource_group.vnet.location
  location_short      = local.location_short[azurerm_resource_group.vnet.location]
  resource_group_name = azurerm_resource_group.vnet.name
  project             = local.project

  vnet_cidr_block = "10.20.0.0/16"
  pep_snet_cidr   = ["10.20.2.0/23"]

  tags = local.tags
}

data "azurerm_resource_group" "vnet_weu" {
  name = format("%s-rg-common", local.project_legacy)
}

module "networking_weu" {
  source = "../_modules/networking"

  location            = data.azurerm_resource_group.vnet_weu.location
  location_short      = local.location_short[data.azurerm_resource_group.vnet_weu.location]
  resource_group_name = data.azurerm_resource_group.vnet_weu.name
  project             = local.project_legacy

  vnet_cidr_block = "10.0.0.0/16"
  pep_snet_cidr   = ["10.0.240.0/23"]

  ng_ips_number = 2

  tags = local.tags
}
