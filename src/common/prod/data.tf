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

data "azurerm_linux_web_app" "firmaconio_selfcare_web_app" {
  name                = "${local.project_weu_legacy}-sign-backoffice-app"
  resource_group_name = "${local.project_weu_legacy}-sign-backend-rg"
}

# AD Groups
data "azuread_group" "platform_admins" {
  display_name = "${local.prefix}-${local.env_short}-adgroup-platform-admins"
}

data "azuread_group" "wallet_admins" {
  display_name = "${local.prefix}-${local.env_short}-adgroup-wallet-admins"
}

data "azuread_group" "com_admins" {
  display_name = "${local.prefix}-${local.env_short}-adgroup-com-admins"
}

data "azuread_group" "com_devs" {
  display_name = "${local.prefix}-${local.env_short}-adgroup-com-developers"
}

data "azuread_group" "svc_admins" {
  display_name = "${local.prefix}-${local.env_short}-adgroup-svc-admins"
}

data "azuread_group" "svc_devs" {
  display_name = "${local.prefix}-${local.env_short}-adgroup-svc-developers"
}

data "azuread_group" "auth_admins" {
  display_name = "${local.prefix}-${local.env_short}-adgroup-auth-admins"
}

data "azuread_group" "auth_devs" {
  display_name = "${local.prefix}-${local.env_short}-adgroup-auth-developers"
}

data "azuread_group" "bonus_admins" {
  display_name = "${local.prefix}-${local.env_short}-adgroup-bonus-admins"
}

data "azuread_group" "admins" {
  display_name = "${local.prefix}-${local.env_short}-adgroup-admin"
}

# Managed Identity
data "azurerm_user_assigned_identity" "auth_n_identity_infra_ci" {
  name                = "${local.prefix}-${local.env_short}-itn-auth-infra-github-ci-id-01"
  resource_group_name = "${local.prefix}-${local.env_short}-itn-auth-rg-01"
}

data "azurerm_user_assigned_identity" "auth_n_identity_infra_cd" {
  name                = "${local.prefix}-${local.env_short}-itn-auth-infra-github-cd-id-01"
  resource_group_name = "${local.prefix}-${local.env_short}-itn-auth-rg-01"
}

data "azurerm_user_assigned_identity" "bonus_infra_cd" {
  name                = "${local.prefix}-${local.env_short}-itn-cdc-infra-github-cd-id-01"
  resource_group_name = "${local.prefix}-${local.env_short}-itn-cdc-rg-01"
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
  name                = "${local.project_itn}-auth-profile-func-02"
  resource_group_name = "${local.project_itn}-auth-main-rg-01"
}

data "azurerm_linux_function_app" "com_citizen_func" {
  name                = "${local.project_itn}-com-citizen-func-01"
  resource_group_name = "${local.project_itn}-com-rg-01"
}

data "azurerm_linux_function_app" "services_app_backend_function_app" {
  resource_group_name = "${local.project_itn}-svc-rg-01"
  name                = "${local.project_itn}-svc-app-be-func-01"
}

data "azurerm_linux_function_app" "lollipop_function" {
  name                = "${local.project_itn}-auth-lollipop-func-02"
  resource_group_name = "${local.project_itn}-auth-lollipop-rg-02"
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

data "azurerm_linux_function_app" "wallet_user_uat" {
  resource_group_name = "${local.project_itn}-wallet-rg-01"
  name                = "${local.prefix}-u-${local.location_short.italynorth}-wallet-user-func-01"
}

data "azurerm_subnet" "admin_snet" {
  name                 = "${local.project_weu_legacy}-admin-snet"
  resource_group_name  = local.core.networking.weu.vnet_common.resource_group_name
  virtual_network_name = local.core.networking.weu.vnet_common.name
}

data "azurerm_subnet" "itn_auth_lv_func_snet" {
  name                 = "${local.project_itn}-auth-lv-func-snet-02"
  resource_group_name  = local.core.networking.itn.vnet_common.resource_group_name
  virtual_network_name = local.core.networking.itn.vnet_common.name
}

data "azurerm_subnet" "itn_auth_prof_async_func_snet" {
  name                 = "${local.project_itn}-auth-profas-func-snet-02"
  resource_group_name  = local.core.networking.itn.vnet_common.resource_group_name
  virtual_network_name = local.core.networking.itn.vnet_common.name
}

data "azurerm_subnet" "itn_msgs_sending_func_snet" {
  name                 = "${local.project_itn}-msgs-sending-func-snet-01"
  resource_group_name  = local.core.networking.itn.vnet_common.resource_group_name
  virtual_network_name = local.core.networking.itn.vnet_common.name
}

# Key Vaults

data "azurerm_key_vault" "ioweb_kv" {
  name                = "${local.project_itn}-ioweb-kv-01"
  resource_group_name = "${local.project_itn}-auth-main-rg-01"
}
