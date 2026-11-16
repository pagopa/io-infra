module "iam_adgroup_admins" {

  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 5.0"

  subscription_id = var.subscription_id
  principal_id    = var.azure_adgroup_admin_object_id

  storage_blob = [
    {
      storage_account_name = azurerm_storage_account.terraform_state_itn.name
      resource_group_name  = azurerm_storage_account.terraform_state_itn.resource_group_name
      role                 = "owner"
      description          = "Grant AD Admins ownership of the storage account"
    }
  ]
}

module "iam_adgroup_platform_admins" {

  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 5.0"

  subscription_id = var.subscription_id
  principal_id    = var.azure_adgroup_platform_admins_object_id

  storage_blob = [
    {
      storage_account_name = azurerm_storage_account.terraform_state_itn.name
      resource_group_name  = azurerm_storage_account.terraform_state_itn.resource_group_name
      role                 = "writer"
      description          = "Grant Platform Admins write on the storage account"
    }
  ]
}

module "iam_adgroup_platform_externals" {

  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 5.0"

  subscription_id = var.subscription_id
  principal_id    = var.azure_adgroup_platform_externals_object_id

  storage_blob = [
    {
      storage_account_name = azurerm_storage_account.terraform_state_itn.name
      resource_group_name  = azurerm_storage_account.terraform_state_itn.resource_group_name
      role                 = "writer"
      description          = "Grant Platform Externals write on the storage account"
    }
  ]
}

module "iam_adgroup_wallet_admins" {

  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 5.0"

  subscription_id = var.subscription_id
  principal_id    = var.azure_adgroup_wallet_admins_object_id

  storage_blob = [
    {
      storage_account_name = azurerm_storage_account.terraform_state_itn.name
      resource_group_name  = azurerm_storage_account.terraform_state_itn.resource_group_name
      role                 = "writer"
      description          = "Grant Wallet Admins write on the storage account"
    }
  ]
}

module "iam_adgroup_wallet_devs" {

  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 5.0"

  subscription_id = var.subscription_id
  principal_id    = var.azure_adgroup_wallet_devs_object_id

  storage_blob = [
    {
      storage_account_name = azurerm_storage_account.terraform_state_itn.name
      resource_group_name  = azurerm_storage_account.terraform_state_itn.resource_group_name
      role                 = "writer"
      description          = "Grant Wallet Devs write on the storage account"
    }
  ]
}

module "iam_adgroup_com_admins" {

  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 5.0"

  subscription_id = var.subscription_id
  principal_id    = var.azure_adgroup_com_admins_object_id

  storage_blob = [
    {
      storage_account_name = azurerm_storage_account.terraform_state_itn.name
      resource_group_name  = azurerm_storage_account.terraform_state_itn.resource_group_name
      role                 = "writer"
      description          = "Grant Com Admins write on the storage account"
    }
  ]
}

module "iam_adgroup_com_devs" {

  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 5.0"

  subscription_id = var.subscription_id
  principal_id    = var.azure_adgroup_com_devs_object_id

  storage_blob = [
    {
      storage_account_name = azurerm_storage_account.terraform_state_itn.name
      resource_group_name  = azurerm_storage_account.terraform_state_itn.resource_group_name
      role                 = "writer"
      description          = "Grant Com Devs write on the storage account"
    }
  ]
}

module "iam_adgroup_svc_admins" {

  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 5.0"

  subscription_id = var.subscription_id
  principal_id    = var.azure_adgroup_svc_admins_object_id

  storage_blob = [
    {
      storage_account_name = azurerm_storage_account.terraform_state_itn.name
      resource_group_name  = azurerm_storage_account.terraform_state_itn.resource_group_name
      role                 = "writer"
      description          = "Grant SVC Admins write on the storage account"
    }
  ]
}

module "iam_adgroup_svc_devs" {

  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 5.0"

  subscription_id = var.subscription_id
  principal_id    = var.azure_adgroup_svc_devs_object_id

  storage_blob = [
    {
      storage_account_name = azurerm_storage_account.terraform_state_itn.name
      resource_group_name  = azurerm_storage_account.terraform_state_itn.resource_group_name
      role                 = "writer"
      description          = "Grant SVC Devs write on the storage account"
    }
  ]
}

module "iam_adgroup_auth_admins" {

  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 5.0"

  subscription_id = var.subscription_id
  principal_id    = var.azure_adgroup_auth_admins_object_id

  storage_blob = [
    {
      storage_account_name = azurerm_storage_account.terraform_state_itn.name
      resource_group_name  = azurerm_storage_account.terraform_state_itn.resource_group_name
      role                 = "writer"
      description          = "Grant Auth Admins write on the storage account"
    }
  ]
}

module "iam_adgroup_auth_devs" {

  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 5.0"

  subscription_id = var.subscription_id
  principal_id    = var.azure_adgroup_auth_devs_object_id

  storage_blob = [
    {
      storage_account_name = azurerm_storage_account.terraform_state_itn.name
      resource_group_name  = azurerm_storage_account.terraform_state_itn.resource_group_name
      role                 = "writer"
      description          = "Grant Auth Devs write on the storage account"
    }
  ]
}

module "iam_adgroup_bonus_admins" {

  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 5.0"

  subscription_id = var.subscription_id
  principal_id    = var.azure_adgroup_bonus_admins_object_id

  storage_blob = [
    {
      storage_account_name = azurerm_storage_account.terraform_state_itn.name
      resource_group_name  = azurerm_storage_account.terraform_state_itn.resource_group_name
      role                 = "writer"
      description          = "Grant Bonus Admins write on the storage account"
    }
  ]
}

module "iam_adgroup_bonus_devs" {

  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 5.0"

  subscription_id = var.subscription_id
  principal_id    = var.azure_adgroup_bonus_devs_object_id

  storage_blob = [
    {
      storage_account_name = azurerm_storage_account.terraform_state_itn.name
      resource_group_name  = azurerm_storage_account.terraform_state_itn.resource_group_name
      role                 = "writer"
      description          = "Grant Bonus Devs write on the storage account"
    }
  ]
}

module "iam_messages_sp" {

  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 5.0"

  subscription_id = var.subscription_id
  principal_id    = var.messages_sp_object_id

  storage_blob = [
    {
      storage_account_name = azurerm_storage_account.terraform_state_itn.name
      resource_group_name  = azurerm_storage_account.terraform_state_itn.resource_group_name
      role                 = "writer"
      description          = "Allow DevOps messages pipelines to read TF state file"
    }
  ]
}
