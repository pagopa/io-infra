data "azurerm_client_config" "current" {}

# RG

data "azurerm_resource_group" "itn_common" {
  name = "io-d-itn-common-rg-01"
}

# VNET

data "azurerm_virtual_network" "itn_common" {
  name                = "io-d-itn-common-vnet-01"
  resource_group_name = "io-d-itn-common-rg-01"
}

# Application Insight

data "azurerm_application_insights" "itn_ai" {
  name                = "io-d-ai-common"
  resource_group_name = "io-d-rg-common"
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

data "azuread_group" "svc_admins" {
  display_name = "${local.prefix}-${local.env_short}-adgroup-svc-admins"
}

data "azuread_group" "auth_admins" {
  display_name = "${local.prefix}-${local.env_short}-adgroup-auth-admins"
}

data "azuread_group" "bonus_admins" {
  display_name = "${local.prefix}-${local.env_short}-adgroup-bonus-admins"
}