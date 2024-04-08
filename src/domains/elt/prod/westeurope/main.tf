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

resource "azurerm_resource_group" "elt_rg" {
  name     = format("%s-elt-rg", local.project)
  location = local.location

  tags = local.tags
}

module "networking" {
  source = "../../_modules/networking"

  project = local.project

  # inferred from vnet-common with cidr 10.0.0.0/16
  # https://github.com/pagopa/io-infra/blob/d5101ef7b24bc262b8a7773a9690a00afe9ec92e/src/core/network.tf#L8
  cidr_subnet_elt = ["10.0.11.0/24"]

  tags = local.tags
}

module "storage_accounts" {
  source = "../../_modules/storage_accounts"

  project             = local.project
  location            = local.location
  resource_group_name = azurerm_resource_group.elt_rg.name

  tags = local.tags
}

module "function_apps" {
  source = "../../_modules/function_apps"

  project                         = local.project
  location                        = local.location
  secondary_location_display_name = local.secondary_location_display_name
  resource_group_name             = azurerm_resource_group.elt_rg.name

  vnet_name = module.networking.vnet_common.name
  subnet_id = module.networking.subnet_elt.id

  storage_account_name                      = module.storage_accounts.storage_account_elt.name
  storage_account_primary_access_key        = module.storage_accounts.storage_account_elt_primary_access_key
  storage_account_primary_connection_string = module.storage_accounts.storage_account_elt_primary_connection_string

  storage_account_tables = {
    fnelterrors                     = module.storage_accounts.storage_account_tables.fnelterrors
    fnelterrors_messages            = module.storage_accounts.storage_account_tables.fnelterrors_messages
    fnelterrors_message_status      = module.storage_accounts.storage_account_tables.fnelterrors_message_status
    fnelterrors_notification_status = module.storage_accounts.storage_account_tables.fnelterrors_notification_status
    fneltcommands                   = module.storage_accounts.storage_account_tables.fneltcommands
    fneltexports                    = module.storage_accounts.storage_account_tables.fneltexports
  }

  storage_account_containers = {
    container_messages_report_step1      = module.storage_accounts.storage_account_containers.container_messages_report_step1
    container_messages_report_step_final = module.storage_accounts.storage_account_containers.container_messages_report_step_final
  }

  tags = local.tags
}
