module "storage_accounts" {
  source = "../_modules/storage_accounts"

  project                   = local.project_itn
  subscription_id           = data.azurerm_subscription.current.subscription_id
  location                  = "italynorth"
  resource_group_common     = local.core.resource_groups.italynorth.common
  resource_group_operations = local.core.resource_groups.westeurope.operations

  azure_adgroup_admins_object_id = data.azuread_group.admins.object_id

  tags = local.tags
}