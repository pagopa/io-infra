# TODO: remove when apim v2 module is implemented
data "azurerm_api_management" "apim_v2" {
  name                = "${local.project_weu_legacy}-apim-v2-api"
  resource_group_name = "${local.project_weu_legacy}-rg-internal"
}

data "azurerm_virtual_network" "weu_beta" {
  name                = "${local.project_weu}-beta-vnet"
  resource_group_name = "${local.project_weu}-beta-vnet-rg"
}

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

# TODO: remove if app_backend module is moved in core or common
data "azurerm_linux_web_app" "app_backendl1" {
  name                = "${local.project_weu_legacy}-app-appbackendl1"
  resource_group_name = "${local.project_weu_legacy}-rg-linux"
}

# TODO: remove if app_backend module is moved in core or common
data "azurerm_linux_web_app" "app_backendl2" {
  name                = "${local.project_weu_legacy}-app-appbackendl2"
  resource_group_name = "${local.project_weu_legacy}-rg-linux"
}

# CDN
data "azurerm_linux_function_app" "function_assets_cdn" {
  name                = "${local.project_weu_legacy}-assets-cdn-fn"
  resource_group_name = "${local.project_weu_legacy}-assets-cdn-rg"
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

data "azurerm_subnet" "functions_fast_login_snet" {
  name                 = "${local.project_weu}-fast-login-snet"
  virtual_network_name = local.core.networking.weu.vnet_common.name
  resource_group_name  = local.core.networking.weu.vnet_common.resource_group_name
}

data "azurerm_subnet" "functions_service_messages_snet" {
  name                 = "${local.project_weu_legacy}-fn-service-messages-snet"
  virtual_network_name = local.core.networking.weu.vnet_common.name
  resource_group_name  = local.core.networking.weu.vnet_common.resource_group_name
}

data "azurerm_subnet" "itn_msgs_sending_func_snet" {
  name                 = "${local.project_itn}-msgs-sending-func-snet-01"
  virtual_network_name = local.core.networking.itn.vnet_common.name
  resource_group_name  = local.core.networking.itn.vnet_common.resource_group_name
}