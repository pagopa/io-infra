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

data "terraform_remote_state" "platform_core" {
  backend = "azurerm"

  config = {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "iopitntfst001"
    container_name       = "terraform-state"
    key                  = "io-infra.platform.core.prod.tfstate"
    use_azuread_auth     = true
  }
}

data "terraform_remote_state" "platform_observability" {
  backend = "azurerm"

  config = {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "iopitntfst001"
    container_name       = "terraform-state"
    key                  = "io-infra.platform.observability.prod.tfstate"
    use_azuread_auth     = true
  }
}

# Cosmos

data "azurerm_subnet" "cosmos_api_allowed" {
  for_each = toset(local.cosmos_api.allowed_subnets)

  name                 = each.value
  virtual_network_name = local.core.networking.weu.vnet_common.name
  resource_group_name  = local.core.networking.weu.vnet_common.resource_group_name
}

# AD Groups

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

# Managed Identities

data "azurerm_user_assigned_identity" "auth_n_identity_infra_ci" {
  name                = "${local.prefix}-${local.env_short}-itn-auth-infra-github-ci-id-01"
  resource_group_name = "${local.prefix}-${local.env_short}-itn-auth-rg-01"
}

data "azurerm_user_assigned_identity" "auth_n_identity_infra_cd" {
  name                = "${local.prefix}-${local.env_short}-itn-auth-infra-github-cd-id-01"
  resource_group_name = "${local.prefix}-${local.env_short}-itn-auth-rg-01"
}