terraform {

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

data "azurerm_subscription" "current" {}


module "common_values" {
  source = "github.com/pagopa/io-infra//src/_modules/common_values?ref=main"
}