data "azurerm_client_config" "current" {}

data "azurerm_subscription" "current" {}

data "azurerm_virtual_network" "weu_beta" {
  name                = "${local.project_weu}-beta-vnet"
  resource_group_name = "${local.project_weu}-beta-vnet-rg"
}

data "azurerm_virtual_network" "weu_prod01" {
  name                = "${local.project_weu}-prod01-vnet"
  resource_group_name = "${local.project_weu}-prod01-vnet-rg"
}

data "azuread_group" "adgroup_admin" {
  display_name = "${local.prefix}-${local.env_short}-adgroup-admin"
}

data "azuread_group" "adgroup_developers" {
  display_name = "${local.prefix}-${local.env_short}-adgroup-developers"
}

#pagopaspa-cstar-platform-iac-projects-{subscription}
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
