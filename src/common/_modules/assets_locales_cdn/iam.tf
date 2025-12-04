module "roles_svc_devs" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 1.0"

  subscription_id = var.subscription_id
  principal_id    = var.azure_adgroup_svc_devs_object_id

  storage_blob = [
    {
      storage_account_name = module.cdn_storage.name
      resource_group_name  = module.cdn_storage.resource_group_name
      description          = "Writer access on all the storage account for roles_svc_devs"
      role                 = "writer"
    }
  ]
}
