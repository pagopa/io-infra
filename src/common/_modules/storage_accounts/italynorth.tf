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

resource "azurerm_storage_account" "iopitnlogst01" {

  count = var.location == "italynorth" ? 1 : 0

  name                     = replace("${var.project}logst01", "-", "")
  resource_group_name      = var.resource_group_operations
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "ZRS" # GZRS not available at the moment in ITN

  public_network_access_enabled     = false
  allow_nested_items_to_be_public   = true
  large_file_share_enabled          = false
  cross_tenant_replication_enabled  = true
  infrastructure_encryption_enabled = true

  blob_properties {
    versioning_enabled  = true
    change_feed_enabled = true
  }

  tags = var.tags
}

resource "azurerm_storage_management_policy" "iopitnlogst01" {

  count = var.location == "italynorth" ? 1 : 0

  depends_on         = [azurerm_storage_account.iopitnlogst01]
  storage_account_id = azurerm_storage_account.iopitnlogst01[0].id
  rule {
    name    = "insightlogs1year"
    enabled = true
    filters {
      prefix_match = ["insights-activity-logs",
        "insights-logs-applicationgatewayaccesslog",
        "insights-logs-auditlogs",
        "insights-logs-noninteractiveusersigninlogs",
      "insights-logs-serviceprincipalsigninlogs"]
      blob_types = ["appendBlob"]
    }
    actions {
      base_blob {
        delete_after_days_since_modification_greater_than = 365
      }
    }
  }
}

resource "azurerm_storage_encryption_scope" "iopitnlogst01" {

  count = var.location == "italynorth" ? 1 : 0

  depends_on                         = [azurerm_storage_account.iopitnlogst01]
  name                               = "logsencryption"
  storage_account_id                 = azurerm_storage_account.iopitnlogst01[0].id
  source                             = "Microsoft.Storage"
  infrastructure_encryption_required = true
}

resource "azurerm_storage_account" "retirements_itn_01" {
  count = var.location == "italynorth" ? 1 : 0

  name                     = replace("${var.project}retirementsst01", "-", "")
  resource_group_name      = var.resource_group_common
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  access_tier              = "Cool"

  public_network_access_enabled    = true
  allow_nested_items_to_be_public  = false
  shared_access_key_enabled        = false
  default_to_oauth_authentication  = true
  cross_tenant_replication_enabled = false

  tags = var.tags
}
