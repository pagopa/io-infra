module "iam_adgroup_product_admins" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 0.0"

  principal_id = var.azure_adgroup_platform_admins_object_id

  apim = [
    {
      name                = module.io_proxy.name
      resource_group_name = module.io_proxy.resource_group_name
      role                = "owner"
    }
  ]
}