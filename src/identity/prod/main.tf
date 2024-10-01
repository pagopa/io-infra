terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.105.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "tfappprodio"
    container_name       = "terraform-state"
    key                  = "io-infra.identity.tfstate"
  }
}

provider "azurerm" {
  features {
  }
}

provider "azurerm" {
  alias           = "prod-trial"
  subscription_id = "a2124115-ba74-462f-832a-9192cbd03649"

  features {}
}

provider "azurerm" {
  alias           = "uat-cgn"
  subscription_id = "d1a90d9f-6ee1-4fb2-a149-7aedbf3ed49d"

  features {}
}

module "federated_identities" {
  source = "github.com/pagopa/dx//infra/modules/azure_federated_identity_with_github?ref=main"

  prefix    = local.prefix
  env_short = local.env_short
  env       = local.env
  domain    = local.domain

  repositories = [local.repo_name]

  continuos_integration = {
    enable = true
    roles = {
      subscription = [
        "Reader",
        "PagoPA IaC Reader",
        "Reader and Data Access",
        "Storage Blob Data Reader",
        "Storage File Data SMB Share Reader",
        "Storage Queue Data Reader",
        "Storage Table Data Reader",
        "Key Vault Reader",
        "DocumentDB Account Contributor",
        "API Management Service Contributor",
      ]
      resource_groups = {
        terraform-state-rg = [
          "Storage Blob Data Contributor"
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
        "Storage File Data SMB Share Contributor",
        "Storage Queue Data Contributor",
        "Storage Table Data Contributor",
        "Key Vault Contributor",
      ]
      resource_groups = {}
    }
  }

  tags = local.tags
}

resource "azurerm_role_assignment" "ci_trial_system" {
  provider             = azurerm.prod-trial
  scope                = data.azurerm_subscription.trial_system.id
  principal_id         = module.federated_identities.federated_ci_identity.id
  role_definition_name = "Reader"
}

resource "azurerm_role_assignment" "cd_trial_system" {
  provider             = azurerm.prod-trial
  scope                = data.azurerm_subscription.trial_system.id
  principal_id         = module.federated_identities.federated_ci_identity.id
  role_definition_name = "Reader"
}

resource "azurerm_role_assignment" "ci_cgn_uat" {
  provider             = azurerm.uat-cgn
  scope                = data.azurerm_subscription.cgn_uat.id
  principal_id         = module.federated_identities.federated_ci_identity.id
  role_definition_name = "Reader"
}

resource "azurerm_role_assignment" "cd_cgn_uat" {
  provider             = azurerm.uat-cgn
  scope                = data.azurerm_subscription.cgn_uat.id
  principal_id         = module.federated_identities.federated_ci_identity.id
  role_definition_name = "Reader"
}