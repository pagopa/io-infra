terraform {

  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "iopitntfst001"
    container_name       = "terraform-state"
    key                  = "io-infra.common.prod.tfstate"
    use_azuread_auth     = true
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.1.0, < 5.0.0"
    }
  }
}

provider "azurerm" {
  features {}
  storage_use_azuread = true
}

import {
  to = module.storage_accounts.azurerm_storage_account.exportdata_weu_01
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-operations/providers/Microsoft.Storage/storageAccounts/iopstexportdata"
}

import {
  to = module.apim_itn.module.apim_v2.azurerm_private_dns_a_record.apim_scm_azure_api_net
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/scm.azure-api.net/A/io-p-itn-apim-01"
}

import {
  to = module.apim_itn.module.apim_v2.azurerm_private_dns_a_record.apim_management_azure_api_net
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/management.azure-api.net/A/io-p-itn-apim-01"
}

import {
  to = module.apim_itn.module.apim_v2.azurerm_private_dns_a_record.apim_azure_api_net
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/privateDnsZones/azure-api.net/A/io-p-itn-apim-01"
}

import {
  to = module.apim_itn.module.apim_v2.azurerm_api_management_diagnostic.applicationinsights[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ApiManagement/service/io-p-itn-apim-01/diagnostics/applicationinsights"
}
