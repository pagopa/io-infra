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

data "azurerm_private_endpoint_connection" "psn_appgw" {
  name                = "${local.project_itn}-psn-agw-pep-01"
  resource_group_name = local.core.networking.itn.vnet_common.resource_group_name
}

data "azuread_group" "svc_devs" {
  display_name = "${local.prefix}-${local.env_short}-adgroup-svc-developers"
}