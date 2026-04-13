terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 4.21.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "<= 2.33.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}

module "common_values" {
  source = "../../_modules/common_values"
}
