module "exportdata_weu_01_com_admins" {
  count = var.location == "westeurope" ? 1 : 0

  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 0.0"

  principal_id = var.azure_adgroup_com_admins_object_id

  storage_blob = [
    {
      storage_account_name = azurerm_storage_account.exportdata_weu_01[0].name
      resource_group_name  = var.resource_group_operations
      role                 = "writer"
    }
  ]

  storage_queue = [
    {
      storage_account_name = azurerm_storage_account.exportdata_weu_01[0].name
      resource_group_name  = var.resource_group_operations
      role                 = "owner"
    }
  ]

  storage_table = [
    {
      storage_account_name = azurerm_storage_account.exportdata_weu_01[0].name
      resource_group_name  = var.resource_group_operations
      role                 = "writer"
    }
  ]
}

module "exportdata_weu_01_com_devs" {
  count = var.location == "westeurope" ? 1 : 0

  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 0.0"

  principal_id = var.azure_adgroup_com_devs_object_id

  storage_blob = [
    {
      storage_account_name = azurerm_storage_account.exportdata_weu_01[0].name
      resource_group_name  = var.resource_group_operations
      role                 = "writer"
    }
  ]

  storage_queue = [
    {
      storage_account_name = azurerm_storage_account.exportdata_weu_01[0].name
      resource_group_name  = var.resource_group_operations
      role                 = "owner"
    }
  ]

  storage_table = [
    {
      storage_account_name = azurerm_storage_account.exportdata_weu_01[0].name
      resource_group_name  = var.resource_group_operations
      role                 = "writer"
    }
  ]
}

module "retirements_itn_01_admins" {
  count = var.location == "italynorth" ? 1 : 0

  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 1.0"

  principal_id = var.azure_adgroup_admins_object_id

  storage_blob = [
    {
      storage_account_id = azurerm_storage_account.retirements_itn_01[0].id
      role               = "owner"
      description        = "Allow IO Admin to manage blob files"
    }
  ]

  storage_table = [
    {
      storage_account_id = azurerm_storage_account.retirements_itn_01[0].id
      role               = "owner"
      description        = "Allow IO Admin to manage tables"
    }
  ]
}
