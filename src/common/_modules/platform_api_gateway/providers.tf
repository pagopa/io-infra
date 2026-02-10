terraform {
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~>2.7.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~>2.5.0"
    }
  }
}