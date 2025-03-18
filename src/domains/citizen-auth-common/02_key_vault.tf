removed {
  from = azurerm_resource_group.sec_rg
  lifecycle {
    destroy = false
  }
}

data "azurerm_resource_group" "sec_rg" {
  name = "${local.product}-${var.domain}-sec-rg"
}

module "key_vault" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault?ref=v8.44.1"

  name                       = "${local.product}-${var.domain}-kv"
  location                   = data.azurerm_resource_group.sec_rg.location
  resource_group_name        = data.azurerm_resource_group.sec_rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "premium"
  soft_delete_retention_days = 90

  tags = var.tags
}

## adgroup_admin group policy ##
resource "azurerm_key_vault_access_policy" "adgroup_admin" {
  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_admin.object_id

  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", "GetRotationPolicy", ]
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

## io-p-citizen-auth-kv managed identities reader policy ##
resource "azurerm_key_vault_access_policy" "access_policy_io_infra_ci" {
  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_user_assigned_identity.managed_identity_io_infra_ci.principal_id

  key_permissions         = ["Get", "List", "GetRotationPolicy"]
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
}

resource "azurerm_key_vault_access_policy" "access_policy_io_infra_cd" {
  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_user_assigned_identity.managed_identity_io_infra_cd.principal_id

  key_permissions         = ["Get", "List", "GetRotationPolicy"]
  secret_permissions      = ["Get", "List", "Set"]
  certificate_permissions = ["Get", "List"]
}


# -----------------------------------
#  Auth&Identity monorepo pipelines
# -----------------------------------

resource "azurerm_key_vault_access_policy" "access_policy_auth_n_identity_infra_ci" {
  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_user_assigned_identity.managed_identity_auth_n_identity_infra_ci.principal_id

  key_permissions         = ["Get", "List", "GetRotationPolicy"]
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
}

resource "azurerm_key_vault_access_policy" "access_policy_auth_n_identity_infra_cd" {
  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_user_assigned_identity.managed_identity_auth_n_identity_infra_cd.principal_id

  key_permissions         = ["Get", "List", "GetRotationPolicy"]
  secret_permissions      = ["Get", "List", "Set"]
  certificate_permissions = ["Get", "List"]
}






#
# azure devops policy
#

#pagopaspa-cstar-platform-iac-projects-{subscription}
data "azuread_service_principal" "platform_iac_sp" {
  display_name = "pagopaspa-io-platform-iac-projects-${data.azurerm_subscription.current.subscription_id}"
}

resource "azurerm_key_vault_access_policy" "azdevops_platform_iac_policy" {
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azuread_service_principal.platform_iac_sp.object_id

  secret_permissions      = ["Get", "List", "Set", ]
  storage_permissions     = []
  certificate_permissions = ["SetIssuers", "DeleteIssuers", "Purge", "List", "Get", "ManageContacts", ]
}

resource "azurerm_key_vault_certificate" "lollipop_certificate_v1" {
  name         = "lollipop-certificate-v1"
  key_vault_id = module.key_vault.id

  certificate_policy {
    issuer_parameters {
      name = "Self"
    }

    key_properties {
      exportable = true
      key_size   = 2048
      key_type   = "RSA"
      reuse_key  = false
    }

    secret_properties {
      content_type = "application/x-pem-file"
    }

    x509_certificate_properties {
      key_usage = [
        "cRLSign",
        "dataEncipherment",
        "digitalSignature",
        "keyAgreement",
        "keyCertSign",
        "keyEncipherment",
      ]

      subject            = "CN=${local.lollipop_jwt_host}"
      validity_in_months = 1200
    }
  }
}
