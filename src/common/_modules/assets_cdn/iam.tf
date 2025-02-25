module "roles_svc_devs" {
  source  = "pagopa/dx-azure-role-assignments/azurerm"
  version = "~>0"

  principal_id = var.azure_adgroup_svc_devs_object_id

  storage_blob = [
    {
      storage_account_name = module.assets_cdn_weu.name
      resource_group_name  = module.assets_cdn_weu.resource_group_name
      role                 = "reader"
    },
    {
      storage_account_name = module.assets_cdn_weu.name
      resource_group_name  = module.assets_cdn_weu.resource_group_name
      role                 = "writer"
    }
  ]
}