terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.116.0"
    }
  }
}

provider "azurerm" {
  features {}
}


#--
module "common_values" {
  source = "../../"
}

output "vnets" {
  value = module.common_values.virtual_networks
}

output "pep_snet" {
  value = module.common_values.pep_subnets
}

output "resource_groups" {
  value = module.common_values.resource_groups
}

output "dns_zones" {
  value = module.common_values.dns_zones
}