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

# AD Groups

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

# Function Apps

data "azurerm_linux_function_app" "function_profile" {
  name                = "${local.project_itn}-auth-profile-func-02"
  resource_group_name = "${local.project_itn}-auth-main-rg-01"
}

data "azurerm_linux_function_app" "com_citizen_func" {
  name                = "${local.project_itn}-com-citizen-func-02"
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

data "azurerm_linux_function_app" "io_sign_user" {
  resource_group_name = "${local.project_itn}-sign-rg-01"
  name                = "${local.project_itn}-sign-user-func-01"
}

data "azurerm_linux_function_app" "io_fims_user" {
  resource_group_name = "${local.project_itn}-fims-rg-01"
  name                = "${local.project_itn}-fims-user-func-01"
}