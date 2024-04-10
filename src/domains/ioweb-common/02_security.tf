resource "azurerm_resource_group" "sec_rg" {
  name     = "${local.product}-${var.domain}-sec-rg"
  location = var.location

  tags = var.tags
}

module "key_vault" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault?ref=v4.1.3"

  name                       = "${local.product}-${var.domain}-kv"
  location                   = azurerm_resource_group.sec_rg.location
  resource_group_name        = azurerm_resource_group.sec_rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 90

  tags = var.tags
}

## adgroup_admin group policy ##
resource "azurerm_key_vault_access_policy" "adgroup_admin" {
  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_admin.object_id

  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", ]
  secret_permissions      = ["Get", "List", "Set", "Delete", "Restore", "Recover", ]
  storage_permissions     = []
  certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Restore", "Recover", ]
}

## adgroup_developers group policy ##
resource "azurerm_key_vault_access_policy" "adgroup_developers" {
  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_developers.object_id

  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", ]
  secret_permissions      = ["Get", "List", "Set", "Delete", "Restore", "Recover", ]
  storage_permissions     = []
  certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Restore", "Recover", ]
}

## io-p-ioweb-kv managed identities reader policy ##
resource "azurerm_key_vault_access_policy" "access_policy_io_infra_ci" {
  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_user_assigned_identity.managed_identity_io_infra_ci.principal_id

  key_permissions         = ["Get", "List"]
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
}

resource "azurerm_key_vault_access_policy" "access_policy_io_infra_cd" {
  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_user_assigned_identity.managed_identity_io_infra_cd.principal_id

  key_permissions         = ["Get", "List"]
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
}

resource "azurerm_key_vault_access_policy" "github_action_iac_ci_kv" {
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azuread_service_principal.github_action_iac_ci.object_id

  secret_permissions      = ["Get", "List", ]
  storage_permissions     = []
  certificate_permissions = ["Get", "List", ]
  key_permissions = [
    "Get",
  ]
}

#
# Azure DevOps policy
#
data "azuread_service_principal" "platform_iac_sp" {
  display_name = "pagopaspa-io-platform-iac-projects-${data.azurerm_subscription.current.subscription_id}"
}

resource "azurerm_key_vault_access_policy" "azdevops_platform_iac_policy_ioweb_kv" {
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azuread_service_principal.platform_iac_sp.object_id

  secret_permissions      = ["List", "Get"]
  storage_permissions     = []
  certificate_permissions = ["List", "Get"]
}

resource "azurerm_key_vault_access_policy" "policy_ioweb_cdn_kv" {
  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  # Microsoft.AzureFrontDoor-Cdn object-id
  object_id = "f3b3f72f-4770-47a5-8c1e-aa298003be12"

  secret_permissions      = ["Get", ]
  storage_permissions     = []
  certificate_permissions = ["Get", ]
}

# ####################
# ####################
#       Keys         #
# ####################
# ####################

resource "tls_private_key" "jwt" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# ####################
# ####################
#      Secrets       #
# ####################
# ####################

resource "azurerm_key_vault_secret" "spid_login_jwt_pub_key" {
  name         = "spid-login-jwt-pub-key"
  value        = tls_private_key.jwt.public_key_pem
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "agid_spid_private_key" {
  name         = "spid-login-AGID-SPID-CERT-KEY"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "agid_spid_cert" {
  name         = "spid-login-AGID-SPID-CERT-PEM"
  key_vault_id = module.key_vault.id
}
