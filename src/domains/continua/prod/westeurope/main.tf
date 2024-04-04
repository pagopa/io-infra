terraform {

  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "tfinfprodio"
    container_name       = "terraform-state"
    key                  = "io-infra.continua.tfstate"
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

resource "azurerm_resource_group" "continua_rg" {
  name     = format("%s-continua-rg", local.project)
  location = local.location

  tags = local.tags
}

module "networking" {
  source = "../../_modules/networking"

  project = local.project

  # inferred from vnet-common with cidr 10.0.0.0/16
  # https://github.com/pagopa/io-infra/blob/d5101ef7b24bc262b8a7773a9690a00afe9ec92e/src/core/network.tf#L8
  cidr_subnet_continua = ["10.0.17.64/26"]

  tags = local.tags
}

module "app_services" {
  source = "../../_modules/app_services"

  project             = local.project
  location            = local.location
  resource_group_name = azurerm_resource_group.continua_rg.name

  subnet_id = module.networking.subnet_continua.id

  tags = local.tags
}
