data "azurerm_subscription" "current" {}

data "terraform_remote_state" "core" {
  backend = "azurerm"

  config = {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "iopitntfst02"
    container_name       = "terraform-state"
    key                  = "io-infra.core.prod.tfstate"
    use_azuread_auth     = true
  }
}

data "azurerm_client_config" "current" {}

data "azuread_group" "admins" {
  display_name = "${local.prefix}-${local.env_short}-adgroup-admin"
}