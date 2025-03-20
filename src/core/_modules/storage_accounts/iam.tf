module "iam_adgroup_admins" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 0.0"

  principal_id = var.azure_adgroup_admin_object_id

  storage_blob = [
    {
      storage_account_name = azurerm_storage_account.terraform.name
      resource_group_name  = azurerm_storage_account.terraform.resource_group_name
      role                 = "owner"
    }
  ]
}

module "iam_adgroup_wallet_admins" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 0.0"

  principal_id = var.azure_adgroup_wallet_admins_object_id

  storage_blob = [
    {
      storage_account_name = azurerm_storage_account.terraform.name
      resource_group_name  = azurerm_storage_account.terraform.resource_group_name
      role                 = "writer"
    }
  ]
}

module "iam_adgroup_wallet_devs" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 0.0"

  principal_id = var.azure_adgroup_wallet_devs_object_id

  storage_blob = [
    {
      storage_account_name = azurerm_storage_account.terraform.name
      resource_group_name  = azurerm_storage_account.terraform.resource_group_name
      role                 = "writer"
    }
  ]
}

module "iam_adgroup_com_admins" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 0.0"

  principal_id = var.azure_adgroup_com_admins_object_id

  storage_blob = [
    {
      storage_account_name = azurerm_storage_account.terraform.name
      resource_group_name  = azurerm_storage_account.terraform.resource_group_name
      role                 = "writer"
    }
  ]
}

module "iam_adgroup_com_devs" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 0.0"

  principal_id = var.azure_adgroup_com_devs_object_id

  storage_blob = [
    {
      storage_account_name = azurerm_storage_account.terraform.name
      resource_group_name  = azurerm_storage_account.terraform.resource_group_name
      role                 = "writer"
    }
  ]
}

module "iam_adgroup_svc_admins" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 0.0"

  principal_id = var.azure_adgroup_svc_admins_object_id

  storage_blob = [
    {
      storage_account_name = azurerm_storage_account.terraform.name
      resource_group_name  = azurerm_storage_account.terraform.resource_group_name
      role                 = "writer"
    }
  ]
}

module "iam_adgroup_svc_devs" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 0.0"

  principal_id = var.azure_adgroup_svc_devs_object_id

  storage_blob = [
    {
      storage_account_name = azurerm_storage_account.terraform.name
      resource_group_name  = azurerm_storage_account.terraform.resource_group_name
      role                 = "writer"
    }
  ]
}

module "iam_adgroup_auth_admins" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 0.0"

  principal_id = var.azure_adgroup_auth_admins_object_id

  storage_blob = [
    {
      storage_account_name = azurerm_storage_account.terraform.name
      resource_group_name  = azurerm_storage_account.terraform.resource_group_name
      role                 = "writer"
    }
  ]
}

module "iam_adgroup_auth_devs" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 0.0"

  principal_id = var.azure_adgroup_auth_devs_object_id

  storage_blob = [
    {
      storage_account_name = azurerm_storage_account.terraform.name
      resource_group_name  = azurerm_storage_account.terraform.resource_group_name
      role                 = "writer"
    }
  ]
}

module "iam_adgroup_bonus_admins" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 0.0"

  principal_id = var.azure_adgroup_bonus_admins_object_id

  storage_blob = [
    {
      storage_account_name = azurerm_storage_account.terraform.name
      resource_group_name  = azurerm_storage_account.terraform.resource_group_name
      role                 = "writer"
    }
  ]
}

module "iam_adgroup_bonus_devs" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 0.0"

  principal_id = var.azure_adgroup_bonus_devs_object_id

  storage_blob = [
    {
      storage_account_name = azurerm_storage_account.terraform.name
      resource_group_name  = azurerm_storage_account.terraform.resource_group_name
      role                 = "writer"
    }
  ]
}
