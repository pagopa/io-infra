module "roles_svc_devs" {
  source  = "pagopa/dx-azure-role-assignments/azurerm"
  version = "~>0"

  principal_id = var.azure_adgroup_svc_devs_object_id

  storage_blob = [
    {
      storage_account_name = "iopstcdnassets"
      resource_group_name  = var.resource_group_assets_cdn
      role                 = "reader"
    },
    {
      storage_account_name = "iopstcdnassets"
      resource_group_name  = var.resource_group_assets_cdn
      role                 = "writer"
    }
  ]
}