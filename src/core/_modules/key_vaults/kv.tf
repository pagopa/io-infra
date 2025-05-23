resource "azurerm_key_vault" "kv" {
  name                = local.nonstandard[var.location_short].kv
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
  sku_name            = "standard"

  enabled_for_disk_encryption = true
  purge_protection_enabled    = true
  soft_delete_retention_days  = 15

  network_acls {
    bypass         = "AzureServices"
    default_action = "Allow" #tfsec:ignore:AZU020
  }

  tags = var.tags
}

# Access Policies

resource "azurerm_key_vault_access_policy" "kv_adgroup_admin" {
  key_vault_id = azurerm_key_vault.kv.id

  tenant_id = var.tenant_id
  object_id = var.azure_adgroup_admin_object_id

  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", ]
  secret_permissions      = ["Get", "List", "Set", "Delete", "Restore", "Recover", ]
  storage_permissions     = []
  certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Restore", "Recover", ]
}

resource "azurerm_key_vault_access_policy" "kv_io_infra_ci" {
  key_vault_id = azurerm_key_vault.kv.id

  tenant_id = var.tenant_id
  object_id = var.io_infra_ci_managed_identity_principal_id

  secret_permissions      = ["Get", "List"]
  storage_permissions     = []
  certificate_permissions = ["Get", "List"]
}

resource "azurerm_key_vault_access_policy" "kv_io_infra_cd" {
  key_vault_id = azurerm_key_vault.kv.id

  tenant_id = var.tenant_id
  object_id = var.io_infra_cd_managed_identity_principal_id

  secret_permissions      = ["Get", "List", "Set", ]
  storage_permissions     = []
  certificate_permissions = ["SetIssuers", "DeleteIssuers", "Purge", "List", "Get", "ManageContacts", ]
}

resource "azurerm_key_vault_access_policy" "kv_adgroup_developers" {
  key_vault_id = azurerm_key_vault.kv.id

  tenant_id = var.tenant_id
  object_id = var.azure_adgroup_developers_object_id

  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", ]
  secret_permissions      = ["Get", "List", "Set", "Delete", "Restore", "Recover", ]
  storage_permissions     = []
  certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Restore", "Recover", ]
}

resource "azurerm_key_vault_access_policy" "cdn" {
  key_vault_id = azurerm_key_vault.kv.id

  tenant_id = var.tenant_id
  object_id = "f3b3f72f-4770-47a5-8c1e-aa298003be12"

  secret_permissions      = ["Get", ]
  storage_permissions     = []
  certificate_permissions = ["Get", ]
}

resource "azurerm_key_vault_access_policy" "kv_azdevops_platform_iac" {
  key_vault_id = azurerm_key_vault.kv.id

  tenant_id = var.tenant_id
  object_id = var.platform_iac_sp_object_id

  secret_permissions      = ["Get", "List", "Set", ]
  storage_permissions     = []
  certificate_permissions = ["SetIssuers", "DeleteIssuers", "Purge", "List", "Get", "ManageContacts", ]
}

resource "azurerm_key_vault_access_policy" "kv_adgroup_platform_admins" {
  key_vault_id = azurerm_key_vault.kv.id

  tenant_id = var.tenant_id
  object_id = var.azure_adgroup_platform_admins_object_id

  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", ]
  secret_permissions      = ["Get", "List", "Set", "Delete", "Restore", "Recover", ]
  storage_permissions     = []
  certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Restore", "Recover", ]
}

resource "azurerm_key_vault_access_policy" "kv_adgroup_wallet_admins" {
  key_vault_id = azurerm_key_vault.kv.id

  tenant_id = var.tenant_id
  object_id = var.azure_adgroup_wallet_admins_object_id

  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", ]
  secret_permissions      = ["Get", "List", "Set", "Delete", "Restore", "Recover", ]
  storage_permissions     = []
  certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Restore", "Recover", ]
}

resource "azurerm_key_vault_access_policy" "kv_adgroup_wallet_devs" {
  key_vault_id = azurerm_key_vault.kv.id

  tenant_id = var.tenant_id
  object_id = var.azure_adgroup_wallet_devs_object_id

  key_permissions         = []
  secret_permissions      = ["Get", "List", "Set", "Delete"]
  storage_permissions     = []
  certificate_permissions = []
}

resource "azurerm_key_vault_access_policy" "kv_adgroup_com_admins" {
  key_vault_id = azurerm_key_vault.kv.id

  tenant_id = var.tenant_id
  object_id = var.azure_adgroup_com_admins_object_id

  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", ]
  secret_permissions      = ["Get", "List", "Set", "Delete", "Restore", "Recover", ]
  storage_permissions     = []
  certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Restore", "Recover", ]
}

resource "azurerm_key_vault_access_policy" "kv_adgroup_com_devs" {
  key_vault_id = azurerm_key_vault.kv.id

  tenant_id = var.tenant_id
  object_id = var.azure_adgroup_com_devs_object_id

  key_permissions         = []
  secret_permissions      = ["Get", "List", "Set", "Delete"]
  storage_permissions     = []
  certificate_permissions = []
}

resource "azurerm_key_vault_access_policy" "kv_adgroup_svc_admins" {
  key_vault_id = azurerm_key_vault.kv.id

  tenant_id = var.tenant_id
  object_id = var.azure_adgroup_svc_admins_object_id

  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", ]
  secret_permissions      = ["Get", "List", "Set", "Delete", "Restore", "Recover", ]
  storage_permissions     = []
  certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Restore", "Recover", ]
}

resource "azurerm_key_vault_access_policy" "kv_adgroup_svc_devs" {
  key_vault_id = azurerm_key_vault.kv.id

  tenant_id = var.tenant_id
  object_id = var.azure_adgroup_svc_devs_object_id

  key_permissions         = []
  secret_permissions      = ["Get", "List", "Set", "Delete"]
  storage_permissions     = []
  certificate_permissions = []
}

resource "azurerm_key_vault_access_policy" "kv_adgroup_auth_admins" {
  key_vault_id = azurerm_key_vault.kv.id

  tenant_id = var.tenant_id
  object_id = var.azure_adgroup_auth_admins_object_id

  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", ]
  secret_permissions      = ["Get", "List", "Set", "Delete", "Restore", "Recover", ]
  storage_permissions     = []
  certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Restore", "Recover", ]
}

resource "azurerm_key_vault_access_policy" "kv_adgroup_auth_devs" {
  key_vault_id = azurerm_key_vault.kv.id

  tenant_id = var.tenant_id
  object_id = var.azure_adgroup_auth_devs_object_id

  key_permissions         = []
  secret_permissions      = ["Get", "List", "Set", "Delete"]
  storage_permissions     = []
  certificate_permissions = []
}

resource "azurerm_key_vault_access_policy" "kv_adgroup_bonus_admins" {
  key_vault_id = azurerm_key_vault.kv.id

  tenant_id = var.tenant_id
  object_id = var.azure_adgroup_bonus_admins_object_id

  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", ]
  secret_permissions      = ["Get", "List", "Set", "Delete", "Restore", "Recover", ]
  storage_permissions     = []
  certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Restore", "Recover", ]
}

resource "azurerm_key_vault_access_policy" "kv_adgroup_bonus_devs" {
  key_vault_id = azurerm_key_vault.kv.id

  tenant_id = var.tenant_id
  object_id = var.azure_adgroup_bonus_devs_object_id

  key_permissions         = []
  secret_permissions      = ["Get", "List", "Set", "Delete"]
  storage_permissions     = []
  certificate_permissions = []
}
