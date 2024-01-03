# Azure AD
data "azuread_group" "adgroup_admin" {
  display_name = format("%s-adgroup-admin", local.project)
}

data "azuread_group" "adgroup_directory_readers" {
  display_name = "directory-readers"
}

# kv admin policy
resource "azurerm_key_vault_access_policy" "adgroup_admin" {
  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_admin.object_id

  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", ]
  secret_permissions      = ["Get", "List", "Set", "Delete", "Restore", "Recover", ]
  storage_permissions     = []
  certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Restore", "Recover", ]
}

# kv-common admin policy
resource "azurerm_key_vault_access_policy" "adgroup_admin_common" {
  key_vault_id = module.key_vault_common.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_admin.object_id

  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", ]
  secret_permissions      = ["Get", "List", "Set", "Delete", "Restore", "Recover", ]
  storage_permissions     = []
  certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Restore", "Recover", ]
}

# kv-common reader policy
resource "azurerm_key_vault_access_policy" "adgroup_directory_readers" {
  key_vault_id = module.key_vault_common.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_directory_readers.object_id

  key_permissions         = ["Get", "List"]
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
}

data "azuread_group" "adgroup_developers" {
  display_name = format("%s-adgroup-developers", local.project)
}

# kv developers policy
resource "azurerm_key_vault_access_policy" "adgroup_developers" {
  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_developers.object_id

  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", ]
  secret_permissions      = ["Get", "List", "Set", "Delete", "Restore", "Recover", ]
  storage_permissions     = []
  certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Restore", "Recover", ]
}

# kv-common developers policy
resource "azurerm_key_vault_access_policy" "adgroup_developers_common" {
  key_vault_id = module.key_vault_common.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_developers.object_id

  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", ]
  secret_permissions      = ["Get", "List", "Set", "Delete", "Restore", "Recover", ]
  storage_permissions     = []
  certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Restore", "Recover", ]
}

# Microsoft Azure WebSites
# TODO: To remove, the old app service (api-gad) has been removed so app services not needs to access to key vaults
resource "azurerm_key_vault_access_policy" "app_service" {
  key_vault_id = module.key_vault_common.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = "bb319217-f6ab-45d9-833d-555ef1173316"

  secret_permissions      = ["Get", ]
  storage_permissions     = []
  certificate_permissions = ["Get", ]
}

# Microsoft.AzureFrontDoor-Cdn Enterprise application.
# Note: the application id is always the same in every tenant while the object id is different.
resource "azurerm_key_vault_access_policy" "cdn_common" {
  key_vault_id = module.key_vault_common.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = "f3b3f72f-4770-47a5-8c1e-aa298003be12"

  secret_permissions      = ["Get", ]
  storage_permissions     = []
  certificate_permissions = ["Get", ]
}

resource "azurerm_key_vault_access_policy" "cdn_kv" {
  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = "f3b3f72f-4770-47a5-8c1e-aa298003be12"

  secret_permissions      = ["Get", ]
  storage_permissions     = []
  certificate_permissions = ["Get", ]
}

data "azurerm_key_vault_secret" "sec_workspace_id" {
  count        = var.env_short == "p" ? 1 : 0
  name         = "sec-workspace-id"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "sec_storage_id" {
  count        = var.env_short == "p" ? 1 : 0
  name         = "sec-storage-id"
  key_vault_id = module.key_vault.id
}

#
# azure devops policy
#

#pagopaspa-cstar-platform-iac-projects-{subscription}
data "azuread_service_principal" "platform_iac_sp" {
  display_name = "pagopaspa-io-platform-iac-projects-${data.azurerm_subscription.current.subscription_id}"
}

resource "azurerm_key_vault_access_policy" "azdevops_platform_iac_policy_kv" {
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azuread_service_principal.platform_iac_sp.object_id

  secret_permissions      = ["Get", "List", "Set", ]
  storage_permissions     = []
  certificate_permissions = ["SetIssuers", "DeleteIssuers", "Purge", "List", "Get", "ManageContacts", ]
}

resource "azurerm_key_vault_access_policy" "azdevops_platform_iac_policy_kv_common" {
  key_vault_id = module.key_vault_common.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azuread_service_principal.platform_iac_sp.object_id

  secret_permissions      = ["Get", "List", "Set", ]
  storage_permissions     = []
  certificate_permissions = ["SetIssuers", "DeleteIssuers", "Purge", "List", "Get", "ManageContacts", ]
}

data "azuread_service_principal" "github_action_iac_cd" {
  display_name = "github-pagopa-io-infra-prod-cd"
}

resource "azurerm_key_vault_access_policy" "github_action_iac_cd_kv" {
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azuread_service_principal.github_action_iac_cd.object_id

  secret_permissions      = ["Get", "List", "Set", ]
  storage_permissions     = []
  certificate_permissions = ["SetIssuers", "DeleteIssuers", "Purge", "List", "Get", "ManageContacts", ]
}

resource "azurerm_key_vault_access_policy" "github_action_iac_cd_kv_common" {
  key_vault_id = module.key_vault_common.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azuread_service_principal.github_action_iac_cd.object_id

  secret_permissions      = ["Get", "List", "Set", ]
  storage_permissions     = []
  certificate_permissions = ["SetIssuers", "DeleteIssuers", "Purge", "List", "Get", "ManageContacts", ]
}

data "azuread_service_principal" "github_action_iac_ci" {
  display_name = "github-pagopa-io-infra-prod-ci"
}

resource "azurerm_key_vault_access_policy" "github_action_iac_ci_kv" {
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azuread_service_principal.github_action_iac_ci.object_id

  secret_permissions      = ["Get", "List", ]
  storage_permissions     = []
  certificate_permissions = ["Get", "List", ]
}

resource "azurerm_key_vault_access_policy" "github_action_iac_ci_kv_common" {
  key_vault_id = module.key_vault_common.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azuread_service_principal.github_action_iac_ci.object_id

  secret_permissions      = ["Get", "List", ]
  storage_permissions     = []
  certificate_permissions = ["Get", "List", ]
}
