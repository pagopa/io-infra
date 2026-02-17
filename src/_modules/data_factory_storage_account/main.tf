terraform {
  required_providers {
    azapi = {
      source  = "Azure/azapi"
      version = "<= 1.15.0"
    }
  }
}

module "naming_convention" {
  source  = "pagopa-dx/azure-naming-convention/azurerm"
  version = "~> 0.0"

  environment = {
    prefix          = var.environment.prefix
    env_short       = var.environment.env_short
    location        = var.environment.location
    domain          = var.environment.domain
    app_name        = var.environment.app_name
    instance_number = var.environment.instance_number
  }
}
