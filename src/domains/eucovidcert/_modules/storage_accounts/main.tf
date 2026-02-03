terraform {

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

module "common_values" {
  source = "github.com/pagopa/io-infra//src/_modules/common_values?ref=main"
}