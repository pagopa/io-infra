terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.116.0"
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
  alias           = "prod-cgn"
  subscription_id = "74da48a3-b0e7-489d-8172-da79801086ed"

  features {}
}

provider "azurerm" {
  alias           = "prod-selc"
  subscription_id = "813119d7-0943-46ed-8ebe-cebe24f9106c"

  features {}
}

module "federated_identities" {
  source = "github.com/pagopa/dx//infra/modules/azure_federated_identity_with_github?ref=main"

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
      resource_groups = {
        io-p-itn-common-rg-01 = [
          "Role Based Access Control Administrator"
        ],
        io-p-rg-internal = [
          "Role Based Access Control Administrator"
        ],
        io-p-rg-linux = [
          "Role Based Access Control Administrator"
        ]
      }
    }
  }

  tags = local.tags
}

resource "azurerm_role_assignment" "ci_cgn" {
  provider             = azurerm.prod-cgn
  scope                = data.azurerm_subscription.cgn.id
  principal_id         = module.federated_identities.federated_ci_identity.id
  role_definition_name = "Reader"
}

resource "azurerm_role_assignment" "ci_cgn_iac_reader" {
  provider             = azurerm.prod-cgn
  scope                = data.azurerm_subscription.cgn.id
  principal_id         = module.federated_identities.federated_ci_identity.id
  role_definition_name = "PagoPA IaC Reader"
}

resource "azurerm_role_assignment" "cd_cgn" {
  provider             = azurerm.prod-cgn
  scope                = data.azurerm_subscription.cgn.id
  principal_id         = module.federated_identities.federated_cd_identity.id
  role_definition_name = "Reader"
}

resource "azurerm_role_assignment" "cd_cgn_iac_reader" {
  provider             = azurerm.prod-cgn
  scope                = data.azurerm_subscription.cgn.id
  principal_id         = module.federated_identities.federated_cd_identity.id
  role_definition_name = "PagoPA IaC Reader"
}

resource "azurerm_role_assignment" "cd_selc_evhns" {
  provider             = azurerm.prod-selc
  scope                = "/subscriptions/813119d7-0943-46ed-8ebe-cebe24f9106c/resourceGroups/selc-p-event-rg/providers/Microsoft.EventHub/namespaces/selc-p-eventhub-ns"
  principal_id         = module.federated_identities.federated_cd_identity.id
  role_definition_name = "Contributor"
}
