terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3"
    }
  }

  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "ioditntfst01"
    container_name       = "terraform-state"
    key                  = "io-infra.identity.tfstate"
    use_azuread_auth     = true
  }
}

provider "azurerm" {
  features {
  }
}

module "federated_identities" {
  source  = "pagopa/dx-azure-federated-identity-with-github/azurerm"
  version = "~> 0"

  prefix       = local.prefix
  env_short    = local.env_short
  env          = local.env
  domain       = local.domain
  location     = local.location
  repositories = [local.repo_name]

  continuos_integration = {
    enable = true
    roles = {
      subscription = [
        "Reader",
        "PagoPA IaC Reader",
        "Reader and Data Access",
        "Storage Blob Data Reader",
      ]
      resource_groups = {
        terraform-state-rg = [
          "Storage Blob Data Contributor"
        ]
        io-d-itn-platform-rg-01 = [
          "Owner"
        ]
      }
    }
  }

  continuos_delivery = {
    enable = true
    roles = {
      subscription = [
        "Contributor",
        "Storage Account Contributor",
        "Storage Blob Data Contributor",
        "Key Vault Contributor",
        "Role Based Access Control Administrator",
        "User Access Administrator"
      ]
      resource_groups = {
        io-d-itn-platform-rg-01 = [
          "Owner",
        ]
      }
    }
  }

  tags = local.tags
}
