terraform {

  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "iopitntfst02"
    container_name       = "terraform-state"
    key                  = "io-infra.core.prod.tfstate"
    use_azuread_auth     = true
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.112.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "naming_convention" {
  source  = "pagopa/dx-azure-naming-convention/azurerm"
  version = "0.0.1"

  environment = {
    prefix          = local.prefix
    env_short       = local.env_short
    location        = "italynorth"
    app_name        = "test"
    instance_number = "01"
  }
}
