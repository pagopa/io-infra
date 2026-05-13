module "storage_accounts" {
  source = "../_modules/storage_accounts"

  project                   = local.project_weu_legacy
  subscription_id           = data.azurerm_subscription.current.subscription_id
  location                  = "westeurope"
  resource_group_operations = local.core.resource_groups.westeurope.operations
  resource_group_internal   = local.core.resource_groups.westeurope.internal

  azure_adgroup_com_admins_object_id = data.azuread_group.com_admins.object_id
  azure_adgroup_com_devs_object_id   = data.azuread_group.com_devs.object_id

  tags = local.tags
}