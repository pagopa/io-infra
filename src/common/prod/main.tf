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
      version = "~> 4.1"
    }
  }
}

provider "azurerm" {
  features {}
  storage_use_azuread = true
}

moved {
  from = module.apim_itn.azurerm_network_security_group.apim
  to   = module.apim_itn.module.apim_v2.azurerm_network_security_group.nsg_apim
}

moved {
  from = module.apim_itn.azurerm_subnet_network_security_group_association.apim
  to   = module.apim_itn.module.apim_v2.azurerm_subnet_network_security_group_association.snet_nsg
}
moved {
  from = module.apim_itn.azurerm_private_dns_a_record.apim_azure_api_net
  to   = module.apim_itn.module.apim_v2.azurerm_private_dns_a_record.apim_azure_api_net
}

moved {
  from = module.apim_itn.azurerm_private_dns_a_record.apim_management_azure_api_net
  to   = module.apim_itn.module.apim_v2.azurerm_private_dns_a_record.apim_management_azure_api_net
}

moved {
  from = module.apim_itn.azurerm_private_dns_a_record.apim_scm_azure_api_net
  to   = module.apim_itn.module.apim_v2.azurerm_private_dns_a_record.apim_scm_azure_api_net
}

moved {
  from = module.apim_itn.module.apim_v2.azurerm_api_management_diagnostic.this[0]
  to   = module.apim_itn.module.apim_v2.azurerm_api_management_diagnostic.applicationinsights[0]
}