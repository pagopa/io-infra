resource "azurerm_storage_account" "exportdata_weu_01" {
  count = var.location == "westeurope" ? 1 : 0

  name                     = replace("${var.project}stexportdata", "-", "")
  resource_group_name      = var.resource_group_operations
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GZRS"

  public_network_access_enabled    = true
  shared_access_key_enabled        = true
  allow_nested_items_to_be_public  = false
  cross_tenant_replication_enabled = false

  tags = var.tags
}
