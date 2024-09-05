resource "azurerm_key_vault" "common" {
  name                = local.nonstandard[var.location_short].kv_common
  location            = var.location
  resource_group_name = var.resource_group_common
  tenant_id           = var.tenant_id
  sku_name            = "standard"

  enabled_for_disk_encryption = true
  purge_protection_enabled    = true
  soft_delete_retention_days  = 90

  network_acls {
    bypass         = "AzureServices"
    default_action = "Allow" #tfsec:ignore:AZU020
  }

  tags = var.tags
}

# Access Policies

resource "azurerm_key_vault_access_policy" "kv_common_adgroup_admin" {
  key_vault_id = azurerm_key_vault.common.id

  tenant_id = var.tenant_id
  object_id = var.azure_ad_group_admin_object_id

  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", ]
  secret_permissions      = ["Get", "List", "Set", "Delete", "Restore", "Recover", ]
  storage_permissions     = []
  certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Restore", "Recover", ]
}

resource "azurerm_key_vault_access_policy" "kv_common_io_infra_ci" {
  key_vault_id = azurerm_key_vault.common.id

  tenant_id = var.tenant_id
  object_id = var.io_infra_ci_managed_identity_principal_id

  key_permissions         = ["Get", "List"]
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
}

resource "azurerm_key_vault_access_policy" "kv_common_io_infra_cd" {
  key_vault_id = azurerm_key_vault.common.id

  tenant_id = var.tenant_id
  object_id = var.io_infra_cd_managed_identity_principal_id

  key_permissions         = ["Get", "List"]
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
}

resource "azurerm_key_vault_access_policy" "kv_common_adgroup_developers" {
  key_vault_id = azurerm_key_vault.common.id

  tenant_id = var.tenant_id
  object_id = var.azure_ad_group_developers_object_id

  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", ]
  secret_permissions      = ["Get", "List", "Set", "Delete", "Restore", "Recover", ]
  storage_permissions     = []
  certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Restore", "Recover", ]
}

# Microsoft Azure WebSites
# TODO: To remove, the old app service (api-gad) has been removed so app services not needs to access to key vaults
resource "azurerm_key_vault_access_policy" "app_service" {
  key_vault_id = azurerm_key_vault.common.id

  tenant_id = var.tenant_id
  object_id = "bb319217-f6ab-45d9-833d-555ef1173316"

  secret_permissions      = ["Get"]
  storage_permissions     = []
  certificate_permissions = ["Get"]
}

# Microsoft.AzureFrontDoor-Cdn Enterprise application
resource "azurerm_key_vault_access_policy" "cdn_common" {
  key_vault_id = azurerm_key_vault.common.id

  tenant_id = var.tenant_id
  object_id = "f3b3f72f-4770-47a5-8c1e-aa298003be12"

  secret_permissions      = ["Get", ]
  storage_permissions     = []
  certificate_permissions = ["Get", ]
}

resource "azurerm_key_vault_access_policy" "kv_common_azdevops_platform_iac" {
  key_vault_id = azurerm_key_vault.common.id

  tenant_id = var.tenant_id
  object_id = var.platform_iac_sp_object_id

  secret_permissions      = ["Get", "List", "Set", ]
  storage_permissions     = []
  certificate_permissions = ["SetIssuers", "DeleteIssuers", "Purge", "List", "Get", "ManageContacts", ]
}
