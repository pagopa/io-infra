data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}

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

data "terraform_remote_state" "platform_app_backend" {
  backend = "azurerm"

  config = {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "iopitntfst001"
    container_name       = "terraform-state"
    key                  = "io-infra.platform.app-backend.prod.tfstate"
    use_azuread_auth     = true
  }
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

# Key Vault

data "azurerm_key_vault" "ioweb_kv" {
  name                = "${local.project_itn}-ioweb-kv-01"
  resource_group_name = "${local.project_itn}-ioweb-rg-01"
}

# Web App

data "azurerm_linux_web_app" "firmaconio_selfcare_web_app" {
  name                = "${local.project_itn}-sign-backoffice-app-01"
  resource_group_name = "${local.project_itn}-sign-rg-01"
}

# Managed Identities

data "azurerm_user_assigned_identity" "auth_n_identity_infra_cd" {
  name                = "${local.prefix}-${local.env_short}-itn-auth-infra-github-cd-id-01"
  resource_group_name = "${local.prefix}-${local.env_short}-itn-auth-rg-01"
}

data "azurerm_user_assigned_identity" "bonus_infra_cd" {
  name                = "${local.prefix}-${local.env_short}-itn-cdc-infra-github-cd-id-01"
  resource_group_name = "${local.prefix}-${local.env_short}-itn-cdc-rg-01"
}

data "azurerm_user_assigned_identity" "com_infra_cd" {
  name                = "${local.prefix}-${local.env_short}-itn-msgs-infra-github-cd-id-01"
  resource_group_name = "${local.prefix}-${local.env_short}-itn-msgs-rg-01"
}

data "azurerm_user_assigned_identity" "fims_infra_cd" {
  name                = "${local.prefix}-${local.env_short}-itn-fims-infra-github-cd-id-01"
  resource_group_name = "${local.prefix}-${local.env_short}-itn-fims-rg-01"
}