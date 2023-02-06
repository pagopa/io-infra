terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.40.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.33.0"
    }
  }

  backend "azurerm" {}

  # tflint-ignore: terraform_required_version
  # Due to precommit check update required
  # required_version = ">= 1.3.7"
}

provider "azurerm" {
  features {}
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}
