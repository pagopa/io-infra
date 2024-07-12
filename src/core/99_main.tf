terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.92.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "<= 2.33.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "<= 4.0.4"
    }
    local = {
      source  = "hashicorp/local"
      version = "<= 2.3.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "<= 3.2.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "<= 3.4.3"
    }
    azapi = {
      source  = "azure/azapi"
      version = "<= 1.9.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

provider "azapi" {
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}

provider "azurerm" {
  alias                      = "prod-trial"
  subscription_id            = "a2124115-ba74-462f-832a-9192cbd03649"
  skip_provider_registration = true

  features {}
}        