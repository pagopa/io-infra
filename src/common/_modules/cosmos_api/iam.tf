resource "azurerm_role_assignment" "cosno_api_com_admins" {
  scope                = azurerm_cosmosdb_account.this.id
  principal_id         = var.azure_adgroup_com_admins_object_id
  role_definition_name = "DocumentDB Account Contributor"
}

resource "azurerm_role_assignment" "cosno_api_com_devs" {
  scope                = azurerm_cosmosdb_account.this.id
  principal_id         = var.azure_adgroup_com_devs_object_id
  role_definition_name = "DocumentDB Account Contributor"
}

resource "azurerm_role_assignment" "cosno_api_svc_admins" {
  scope                = azurerm_cosmosdb_account.this.id
  principal_id         = var.azure_adgroup_svc_admins_object_id
  role_definition_name = "DocumentDB Account Contributor"
}

resource "azurerm_role_assignment" "cosno_api_svc_devs" {
  scope                = azurerm_cosmosdb_account.this.id
  principal_id         = var.azure_adgroup_svc_devs_object_id
  role_definition_name = "DocumentDB Account Contributor"
}

resource "azurerm_role_assignment" "cosno_api_auth_admins" {
  scope                = azurerm_cosmosdb_account.this.id
  principal_id         = var.azure_adgroup_auth_admins_object_id
  role_definition_name = "DocumentDB Account Contributor"
}

resource "azurerm_role_assignment" "cosno_api_auth_devs" {
  scope                = azurerm_cosmosdb_account.this.id
  principal_id         = var.azure_adgroup_auth_devs_object_id
  role_definition_name = "DocumentDB Account Contributor"
}

resource "azurerm_role_assignment" "cosno_api_identities" {
  for_each = toset(var.infra_identity_ids)

  scope                = azurerm_cosmosdb_account.this.id
  principal_id         = each.value
  role_definition_name = "DocumentDB Account Contributor"
}

module "cosno_api_com_admins" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 0.0"

  principal_id = var.azure_adgroup_com_admins_object_id

  cosmos = [
    {
      account_name        = azurerm_cosmosdb_account.this.name
      resource_group_name = azurerm_cosmosdb_account.this.resource_group_name
      database            = azurerm_cosmosdb_sql_database.db.name
      role                = "reader"
    }
  ]
}

module "cosno_api_com_devs" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 0.0"

  principal_id = var.azure_adgroup_com_devs_object_id

  cosmos = [
    {
      account_name        = azurerm_cosmosdb_account.this.name
      resource_group_name = azurerm_cosmosdb_account.this.resource_group_name
      database            = azurerm_cosmosdb_sql_database.db.name
      role                = "reader"
    }
  ]
}
module "cosno_api_svc_admins" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 0.0"

  principal_id = var.azure_adgroup_svc_admins_object_id

  cosmos = [
    {
      account_name        = azurerm_cosmosdb_account.this.name
      resource_group_name = azurerm_cosmosdb_account.this.resource_group_name
      database            = azurerm_cosmosdb_sql_database.db.name
      role                = "reader"
    }
  ]
}
module "cosno_api_svc_devs" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 0.0"

  principal_id = var.azure_adgroup_svc_devs_object_id

  cosmos = [
    {
      account_name        = azurerm_cosmosdb_account.this.name
      resource_group_name = azurerm_cosmosdb_account.this.resource_group_name
      database            = azurerm_cosmosdb_sql_database.db.name
      role                = "reader"
    }
  ]
}
module "cosno_api_auth_admins" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 0.0"

  principal_id = var.azure_adgroup_auth_admins_object_id

  cosmos = [
    {
      account_name        = azurerm_cosmosdb_account.this.name
      resource_group_name = azurerm_cosmosdb_account.this.resource_group_name
      database            = azurerm_cosmosdb_sql_database.db.name
      role                = "reader"
    }
  ]
}
module "cosno_api_auth_devs" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 0.0"

  principal_id = var.azure_adgroup_auth_devs_object_id

  cosmos = [
    {
      account_name        = azurerm_cosmosdb_account.this.name
      resource_group_name = azurerm_cosmosdb_account.this.resource_group_name
      database            = azurerm_cosmosdb_sql_database.db.name
      role                = "reader"
    }
  ]
}
