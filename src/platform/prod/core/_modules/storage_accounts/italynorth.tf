#trivy:ignore:AZU-0012
resource "azurerm_storage_account" "iopitndataexportst01" {

  count = var.location == "italynorth" ? 1 : 0

  name                     = replace("${var.project}dataexportst01", "-", "")
  resource_group_name      = var.resource_group_operations
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "ZRS" # GZRS not available at the moment in ITN

  public_network_access_enabled    = false
  shared_access_key_enabled        = true
  allow_nested_items_to_be_public  = false
  large_file_share_enabled         = false
  cross_tenant_replication_enabled = true

  tags = var.tags
}
