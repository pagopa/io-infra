resource "azurerm_key_vault" "tlscert_itn_01" {
  name = "${var.project}-itn-tlscert-kv-01"

  location            = "italynorth"
  resource_group_name = var.resource_group_itn

  sku_name                  = "standard"
  enable_rbac_authorization = true

  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id
  soft_delete_retention_days  = 30
  purge_protection_enabled    = true

  public_network_access_enabled = false

  network_acls {
    bypass         = "AzureServices"
    default_action = "Allow" #tfsec:ignore:AZU020
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "tlscert_kv_itn_01" {
  name                = "${var.project}-itn-tlscert-kv-pep-01"
  location            = azurerm_key_vault.tlscert_itn_01.location
  resource_group_name = azurerm_key_vault.tlscert_itn_01.resource_group_name

  subnet_id = var.subnet_pep_id

  private_service_connection {
    name                           = "${var.project}-itn-tlscert-kv-pep-01"
    private_connection_resource_id = azurerm_key_vault.tlscert_itn_01.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [var.private_dns_zone_id]
  }

  tags = var.tags
}

