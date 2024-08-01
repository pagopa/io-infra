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
