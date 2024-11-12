terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.116.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "<= 2.53.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "<= 3.2.1"
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
  source = "github.com/pagopa/io-infra//src/_modules/common_values?ref=main"
}