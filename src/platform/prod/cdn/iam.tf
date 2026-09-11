module "legacy_cdn_svc_devs" {

  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 1.0"

  principal_id    = data.azuread_group.svc_devs.object_id
  subscription_id = data.azurerm_client_config.current.subscription_id

  storage_blob = [
    {
      storage_account_name = module.legacy_assets_cdn_storage_account.name
      resource_group_name  = module.legacy_assets_cdn_storage_account.resource_group_name
      role                 = "writer"
      description          = "Allow Enti & Servizi to manage blob files"
    }
  ]
}