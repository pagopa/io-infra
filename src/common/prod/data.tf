data "azurerm_virtual_network" "weu_prod01" {
  name                = "${local.project_weu}-prod01-vnet"
  resource_group_name = "${local.project_weu}-prod01-vnet-rg"
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

data "azurerm_client_config" "current" {}

data "azurerm_linux_web_app" "firmaconio_selfcare_web_app" {
  name                = "${local.project_weu_legacy}-sign-backoffice-app"
  resource_group_name = "${local.project_weu_legacy}-sign-backend-rg"
}

# Cosmos API
data "azurerm_subnet" "cosmos_api_allowed" {
  for_each = toset(local.cosmos_api.allowed_subnets)

  name                 = each.value
  virtual_network_name = local.core.networking.weu.vnet_common.name
  resource_group_name  = local.core.networking.weu.vnet_common.resource_group_name
}

# App Backend
data "azurerm_subnet" "services_snet" {
  count                = 2
  name                 = format("%s-services-snet-%d", local.project_weu_legacy, count.index + 1)
  virtual_network_name = local.core.networking.weu.vnet_common.name
  resource_group_name  = local.core.networking.weu.vnet_common.resource_group_name
}

# Functions
data "azurerm_linux_function_app" "function_assets_cdn" {
  name                = "${local.project_weu_legacy}-assets-cdn-fn"
  resource_group_name = "${local.project_weu_legacy}-assets-cdn-rg"
}

data "azurerm_linux_function_app" "function_profile" {
  count               = local.function_profile_count
  name                = "${local.project_itn}-auth-profile-fn-0${count.index + 1}"
  resource_group_name = "${local.project_itn}-profile-rg-0${count.index + 1}"
}

data "azurerm_linux_function_app" "app_messages_xl" {
  count               = local.app_messages_count
  name                = "${local.project_weu_legacy}-weu-com-citizen-func-0${count.index + 1}"
  resource_group_name = "${local.project_weu_legacy}-weu-com-rg-01"
}

data "azurerm_linux_function_app" "services_app_backend_function_app" {
  resource_group_name = "${local.project_itn}-svc-rg-01"
  name                = "${local.project_itn}-svc-app-be-func-01"
}

data "azurerm_linux_function_app" "lollipop_function" {
  name                = "${local.project_itn}-lollipop-fn-01"
  resource_group_name = "${local.project_itn}-lollipop-rg-01"
}

data "azurerm_linux_function_app" "eucovidcert" {
  resource_group_name = "${local.project_weu_legacy}-rg-eucovidcert"
  name                = "${local.project_weu_legacy}-eucovidcert-fn"
}

data "azurerm_linux_function_app" "io_sign_user" {
  resource_group_name = "${local.project_weu_legacy}-sign-backend-rg"
  name                = "${local.project_weu_legacy}-sign-user-func"
}

data "azurerm_linux_function_app" "io_fims_user" {
  resource_group_name = "${local.project_itn}-fims-rg-01"
  name                = "${local.project_itn}-fims-user-func-01"
}

data "azurerm_linux_function_app" "wallet_user" {
  resource_group_name = "${local.project_itn}-wallet-rg-01"
  name                = "${local.project_itn}-wallet-user-func-02"
}

data "azurerm_api_management" "trial_system" {
  provider            = azurerm.prod-trial
  name                = "ts-p-itn-apim-01"
  resource_group_name = "ts-p-itn-routing-rg-01"
}

data "azurerm_subnet" "admin_snet" {
  name                 = "${local.project_weu_legacy}-admin-snet"
  resource_group_name  = local.core.networking.weu.vnet_common.resource_group_name
  virtual_network_name = local.core.networking.weu.vnet_common.name
}

data "azurerm_subnet" "itn_auth_fast_login_func_snet" {
  name                 = "${local.project_itn}-citizen-auth-fast-login-snet-01"
  resource_group_name  = local.core.networking.itn.vnet_common.resource_group_name
  virtual_network_name = local.core.networking.itn.vnet_common.name
}

data "azurerm_subnet" "itn_auth_lv_func_snet" {
  name                 = "${local.project_itn}-auth-lv-func-snet-02"
  resource_group_name  = local.core.networking.itn.vnet_common.resource_group_name
  virtual_network_name = local.core.networking.itn.vnet_common.name
}

data "azurerm_subnet" "itn_msgs_sending_func_snet" {
  name                 = "${local.project_itn}-msgs-sending-func-snet-01"
  resource_group_name  = local.core.networking.itn.vnet_common.resource_group_name
  virtual_network_name = local.core.networking.itn.vnet_common.name
}

