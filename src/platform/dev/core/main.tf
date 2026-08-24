terraform {

  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "ioditntfst01"
    container_name       = "terraform-state"
    key                  = "io-infra.platform.core.dev.tfstate"
    use_azuread_auth     = true
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "< 5.0.0"
    }
  }
}

provider "azurerm" {
  features {
  }
}
