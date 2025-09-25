resource "azurerm_key_vault" "io_p_itn_platform_kv_01" {

  name = "io-p-itn-platform-kv-01"

  location            = "italynorth"
  resource_group_name = var.resource_group_itn
  tenant_id           = var.tenant_id

  sku_name                  = "standard"
  enable_rbac_authorization = true

  enabled_for_disk_encryption = true
  soft_delete_retention_days  = 15
  purge_protection_enabled    = true

  public_network_access_enabled = false

  network_acls {
    bypass         = "AzureServices"
    default_action = "Allow" #tfsec:ignore:AZU020
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "io_p_itn_platform_kv_01" {
  name                = "io-p-itn-platform-kv-pep-01"
  location            = azurerm_key_vault.io_p_itn_platform_kv_01.location
  resource_group_name = azurerm_key_vault.io_p_itn_platform_kv_01.resource_group_name

  subnet_id = var.subnet_pep_id

  private_service_connection {
    name                           = "io-p-itn-platform-kv-pep-01"
    private_connection_resource_id = azurerm_key_vault.io_p_itn_platform_kv_01.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [var.private_dns_zone_id]
  }

  tags = var.tags
}

# RBAC Roles

resource "azurerm_role_assignment" "io_p_itn_platform_kv_01_cdn_secret" {
  scope                = azurerm_key_vault.io_p_itn_platform_kv_01.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = "f3b3f72f-4770-47a5-8c1e-aa298003be12"
}

resource "azurerm_role_assignment" "io_p_itn_platform_kv_01_cdn_cert" {
  scope                = azurerm_key_vault.io_p_itn_platform_kv_01.id
  role_definition_name = "Key Vault Certificates User"
  principal_id         = "f3b3f72f-4770-47a5-8c1e-aa298003be12"
}

resource "azurerm_role_assignment" "io_p_itn_platform_kv_01_azdevops_platform_iac_secret" {
  scope                = azurerm_key_vault.io_p_itn_platform_kv_01.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = var.platform_iac_sp_object_id
}

resource "azurerm_role_assignment" "io_p_itn_platform_kv_01_azdevops_platform_iac_cert" {
  scope                = azurerm_key_vault.io_p_itn_platform_kv_01.id
  role_definition_name = "Key Vault Certificates Officer"
  principal_id         = var.platform_iac_sp_object_id
}

resource "azurerm_role_assignment" "io_p_itn_platform_kv_01_adgroup_admins" {
  for_each             = var.admins
  scope                = azurerm_key_vault.io_p_itn_platform_kv_01.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = each.value
}

resource "azurerm_role_assignment" "io_p_itn_platform_kv_01_adgroup_devs" {
  for_each             = var.devs
  scope                = azurerm_key_vault.io_p_itn_platform_kv_01.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = each.value
}

resource "azurerm_role_assignment" "io_p_itn_platform_kv_01_ci_secret" {
  for_each             = var.ci
  scope                = azurerm_key_vault.io_p_itn_platform_kv_01.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = each.value
}

resource "azurerm_role_assignment" "io_p_itn_platform_kv_01_ci_cert" {
  for_each             = var.ci
  scope                = azurerm_key_vault.io_p_itn_platform_kv_01.id
  role_definition_name = "Key Vault Certificates User"
  principal_id         = each.value
}

resource "azurerm_role_assignment" "io_p_itn_platform_kv_01_cd_secret" {
  for_each             = var.cd
  scope                = azurerm_key_vault.io_p_itn_platform_kv_01.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = each.value
}

resource "azurerm_role_assignment" "io_p_itn_platform_kv_01_cd_cert" {
  for_each             = var.cd
  scope                = azurerm_key_vault.io_p_itn_platform_kv_01.id
  role_definition_name = "Key Vault Certificates Officer"
  principal_id         = each.value
}
