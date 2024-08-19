# TODO: remove when monitor module is implemented
data "azurerm_monitor_action_group" "error_action_group" {
  resource_group_name = "${local.project_weu_legacy}-rg-common"
  name                = "${replace(local.project_weu_legacy, "-", "")}error"
}

data "terraform_remote_state" "core" {
  backend = "azurerm"

  config = {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "iopitntfst001"
    container_name       = "terraform-state"
    key                  = "io-infra.core.prod.italynorth.tfstate"
  }
}