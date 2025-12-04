module "cdn_storage" {
  source = "github.com/pagopa/terraform-azurerm-v4//storage_account?ref=v7.52.0"

  name                            = replace(try(local.nonstandard[var.location_short].st, "${var.project}-assets-st-01"), "-", "")
  account_kind                    = "StorageV2"
  account_tier                    = "Standard"
  access_tier                     = "Hot"
  blob_versioning_enabled         = true
  account_replication_type        = "ZRS" # GZRS not available at the moment in ITN
  resource_group_name             = var.resource_group_common
  location                        = var.location
  advanced_threat_protection      = false
  allow_nested_items_to_be_public = true
  public_network_access_enabled   = true

  index_document     = "index.html"
  error_404_document = "index.html"

  tags = var.tags
}

resource "azurerm_cdn_frontdoor_profile" "cdn_profile" {
  name                     = try(local.nonstandard[var.location_short].cdnp, "${var.project}-assets-cdnp-01")
  resource_group_name      = var.resource_group_assets_cdn
  sku_name                 = "Standard_AzureFrontDoor"
  response_timeout_seconds = 120 # Set to default

  tags = var.tags
}
