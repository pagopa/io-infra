module "roles" {
  source       = "github.com/pagopa/dx//infra/modules/azure_role_assignments?ref=main"
  principal_id = var.function_app.user_func_02.principal_id

  storage_blob = var.what_to_migrate.blob.enabled ? [
    {
      storage_account_name = var.storage_accounts.source.name
      resource_group_name  = var.storage_accounts.source.resource_group_name
      role                 = "reader"
    },
    {
      storage_account_name = var.storage_accounts.target.name
      resource_group_name  = var.storage_accounts.target.resource_group_name
      role                 = "writer"
    }
  ] : []

  # ADF terraform resources still force to use connection strings for tables
  # but it's possible to switch to managed identities from the portal
  storage_table = var.what_to_migrate.table.enabled ? [
    {
      storage_account_name = var.storage_accounts.source.name
      resource_group_name  = var.storage_accounts.source.resource_group_name
      role                 = "reader"
    },
    {
      storage_account_name = var.storage_accounts.target.name
      resource_group_name  = var.storage_accounts.target.resource_group_name
      role                 = "writer"
    }
  ] : []
}