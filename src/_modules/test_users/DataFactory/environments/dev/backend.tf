terraform {
  backend "azurerm" {
    resource_group_name   = "dev-fasanorg"
    storage_account_name  = "stbipdevtest"
    container_name        = "bc-tf-bip-dev-test"
    key                   = "terraform.tfstate"
  }
}
