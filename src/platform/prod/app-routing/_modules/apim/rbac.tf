resource "azurerm_key_vault_access_policy" "apim_kv_policy" {
  key_vault_id = var.key_vault.id
  tenant_id    = var.datasources.azurerm_client_config.tenant_id
  object_id    = module.apim.principal_id

  key_permissions         = []
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
  storage_permissions     = []
}

resource "azurerm_key_vault_access_policy" "common" {
  key_vault_id = var.key_vault_common.id
  tenant_id    = var.datasources.azurerm_client_config.tenant_id
  object_id    = module.apim.principal_id

  key_permissions         = []
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
  storage_permissions     = []
}

module "iam_adgroup_wallet_admins" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 0.0"

  principal_id = var.azure_adgroup_wallet_admins_object_id

  apim = [
    {
      name                = module.apim.name
      resource_group_name = module.apim.resource_group_name
      role                = "owner"
    }
  ]
}

module "iam_adgroup_com_admins" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 0.0"

  principal_id = var.azure_adgroup_com_admins_object_id

  apim = [
    {
      name                = module.apim.name
      resource_group_name = module.apim.resource_group_name
      role                = "owner"
    }
  ]
}

module "iam_adgroup_svc_admins" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 0.0"

  principal_id = var.azure_adgroup_svc_admins_object_id

  apim = [
    {
      name                = module.apim.name
      resource_group_name = module.apim.resource_group_name
      role                = "owner"
    }
  ]
}

module "iam_adgroup_auth_admins" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 0.0"

  principal_id = var.azure_adgroup_auth_admins_object_id

  apim = [
    {
      name                = module.apim.name
      resource_group_name = module.apim.resource_group_name
      role                = "owner"
    }
  ]
}

module "iam_adgroup_bonus_admins" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 0.0"

  principal_id = var.azure_adgroup_bonus_admins_object_id

  apim = [
    {
      name                = module.apim.name
      resource_group_name = module.apim.resource_group_name
      role                = "owner"
    }
  ]
}

module "iam_cgn_pe_backend_app_01" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 0.0"

  principal_id = data.azurerm_linux_web_app.cgn_pe_backend_app_01.identity[0].principal_id

  apim = [
    {
      name                = module.apim.name
      resource_group_name = module.apim.resource_group_name
      role                = "owner"
    }
  ]
}
