resource "azurerm_key_vault" "kv" {
  name                = local.nonstandard[var.location_short].kv
  location            = azurerm_resource_group.sec.location
  resource_group_name = azurerm_resource_group.sec.name
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
