resource "azurerm_resource_group" "assets_cdn_rg" {
  name     = try(local.nonstandard[var.location_short].rg, "${var.project}-assets-cdn-rg-01")
  location = var.location

  tags = var.tags
}

module "assets_cdn" {
  source = "github.com/pagopa/terraform-azurerm-v3//storage_account?ref=v8.27.0"

  name                            = replace(try(local.nonstandard[var.location_short].st, "${var.project}-assets-st-01"), "-", "")
  account_kind                    = "StorageV2"
  account_tier                    = "Standard"
  access_tier                     = "Hot"
  blob_versioning_enabled         = true
  account_replication_type        = "GZRS"
  resource_group_name             = var.resource_groups.common
  location                        = var.location
  advanced_threat_protection      = false
  allow_nested_items_to_be_public = true
  public_network_access_enabled   = true

  index_document     = "index.html"
  error_404_document = "index.html"

  tags = var.tags
}

resource "azurerm_cdn_profile" "assets_cdn_profile" {
  name                = try(local.nonstandard[var.location_short].cdnp, "${var.project}-assets-cdnp-01")
  resource_group_name = azurerm_resource_group.assets_cdn_rg.name
  location            = var.location
  sku                 = "Standard_Microsoft"

  tags = var.tags
}