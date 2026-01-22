module "storage_account_permissions" {
  for_each = var.azure_adgroups_roles

  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 1.0"

  subscription_id = var.subscription_id
  principal_id    = each.value.azureadgroup_id

  storage_blob = [
    {
      storage_account_name = module.cdn_storage.name
      resource_group_name  = module.cdn_storage.resource_group_name
      description          = format("%s role for the group %s", each.value.role, each.value.azureadgroup_id)
      role                 = each.value.role
    }
  ]
}
