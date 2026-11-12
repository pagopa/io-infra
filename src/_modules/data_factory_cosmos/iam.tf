module "roles" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 5.0"

  subscription_id = data.azurerm_subscription.current.id
  principal_id    = var.data_factory_principal_id

  cosmos = [
    {
      account_name        = var.cosmos_accounts.source.name
      resource_group_name = var.cosmos_accounts.source.resource_group_name
      description         = "Azure Data Factory read permissions"
      role                = "reader"
    },
    {
      account_name        = var.cosmos_accounts.target.name
      resource_group_name = var.cosmos_accounts.target.resource_group_name
      description         = "Azure Data Factory write permissions"
      role                = "writer"
    }
  ]
}