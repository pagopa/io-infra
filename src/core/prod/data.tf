data "azurerm_client_config" "current" {}

data "azurerm_subscription" "current" {}

data "azuread_group" "admin" {
  display_name = "${local.prefix}-${local.env_short}-adgroup-admin"
}

data "azuread_group" "developers" {
  display_name = "${local.prefix}-${local.env_short}-adgroup-developers"
}

data "azuread_group" "platform_admins" {
  display_name = "${local.prefix}-${local.env_short}-adgroup-platform-admins"
}

data "azuread_group" "wallet_admins" {
  display_name = "${local.prefix}-${local.env_short}-adgroup-wallet-admins"
}

data "azuread_group" "wallet_devs" {
  display_name = "${local.prefix}-${local.env_short}-adgroup-wallet-developers"
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

data "azuread_group" "bonus_devs" {
  display_name = "${local.prefix}-${local.env_short}-adgroup-bonus-developers"
}

data "azuread_service_principal" "platform_iac_sp" {
  display_name = "pagopaspa-io-platform-iac-projects-${data.azurerm_subscription.current.subscription_id}"
}

data "azurerm_user_assigned_identity" "managed_identity_io_infra_ci" {
  name                = "${local.prefix}-${local.env_short}-infra-github-ci-identity"
  resource_group_name = "${local.prefix}-${local.env_short}-identity-rg"
}

data "azurerm_user_assigned_identity" "managed_identity_io_infra_cd" {
  name                = "${local.prefix}-${local.env_short}-infra-github-cd-identity"
  resource_group_name = "${local.prefix}-${local.env_short}-identity-rg"
}

# TODO: important - this should be removed as it creates a dependency to the common module
# to fix this, we need to move all private dns zones from common to core module

data "azurerm_private_dns_zone" "key_vault" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = "${local.prefix}-${local.env_short}-rg-common"
}
