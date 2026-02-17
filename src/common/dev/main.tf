terraform {

  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "ioditntfst01"
    container_name       = "terraform-state"
    key                  = "io-infra.common.tfstate"
    use_azuread_auth     = true
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4"
    }
  }
}

provider "azurerm" {
  features {
  }
}

resource "azurerm_resource_group" "platform" {
  name     = "${local.project}-platform-rg-01"
  location = local.location

  tags = local.tags
}
