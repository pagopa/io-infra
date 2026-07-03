data "azurerm_client_config" "current" {}

# VNET

data "azurerm_virtual_network" "itn_common" {
  name                = "io-d-itn-common-vnet-01"
  resource_group_name = "io-d-itn-common-rg-01"
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