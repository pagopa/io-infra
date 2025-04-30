module "iam_adgroup_product_admins" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 1.0"

  depends_on = [
    module.io_proxy
  ]

  principal_id    = var.azure_adgroup_platform_admins_object_id
  subscription_id = data.azurerm_client_config.current.subscription_id

  apim = [
    {
      name                = module.io_proxy.name
      resource_group_name = module.io_proxy.resource_group_name
      description         = "Platform team admin group"
      role                = "owner"
    }
  ]
}