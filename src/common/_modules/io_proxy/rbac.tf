module "iam_adgroup_product_admins" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 1.0"

  depends_on = [
    module.io_proxy
  ]

  principal_id = var.azure_adgroup_platform_admins_object_id

  apim = [
    {
      name                = module.io_proxy.name
      resource_group_name = module.io_proxy.resource_group_name
      role                = "owner"
    }
  ]
}