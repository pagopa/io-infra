resource "azurerm_storage_account" "iopitniowebportalsa" {

  name                     = replace("${local.project_itn}iowebportalsa", "-", "")
  resource_group_name      = data.azurerm_resource_group.storage_rg.name
  location                 = local.itn_location
  account_tier             = "Standard"
  account_replication_type = "ZRS" # GZRS not available at the moment in ITN

  public_network_access_enabled    = true
  shared_access_key_enabled        = true
  allow_nested_items_to_be_public  = true
  cross_tenant_replication_enabled = false
  large_file_share_enabled = true

  blob_properties {
    versioning_enabled = true
  }

  tags = var.tags
}