resource "azurerm_key_vault" "common_itn_01" {
  name = "${var.project}-common-kv-01"

  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name                  = "standard"
  enable_rbac_authorization = true

  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id
  soft_delete_retention_days  = 30
  purge_protection_enabled    = true

  network_acls {
    bypass         = "AzureServices"
    default_action = "Allow" #tfsec:ignore:AZU020
  }

  tags = var.tags
}
