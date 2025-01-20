module "roles" {
  source  = "pagopa/dx-azure-role-assignments/azurerm"
  version = "~> 0"

  principal_id = var.data_factory_principal_id

  cosmos = [
    {
      account_name        = var.cosmos_accounts.source.name
      resource_group_name = var.cosmos_accounts.source.resource_group_name
      role                = "reader"
    },
    {
      account_name        = var.cosmos_accounts.target.name
      resource_group_name = var.cosmos_accounts.target.resource_group_name
      role                = "writer"
    }
  ]
}