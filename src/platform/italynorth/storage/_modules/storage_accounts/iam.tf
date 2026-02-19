module "retirements_admins" {

  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 1.0"

  principal_id    = var.azure_adgroup_admins_object_id
  subscription_id = var.subscription_id

  storage_blob = [
    {
      storage_account_name = azurerm_storage_account.retirements.name
      resource_group_name  = azurerm_storage_account.retirements.resource_group_name
      role                 = "owner"
      description          = "Allow IO Admin to manage blob files"
      description          = "Allow IO Admins to manage blob files"
    }
  ]

  storage_table = [
    {
      storage_account_name = azurerm_storage_account.retirements.name
      resource_group_name  = azurerm_storage_account.retirements.resource_group_name
      role                 = "owner"
      description          = "Allow IO Admins to manage tables"
    }
  ]
}