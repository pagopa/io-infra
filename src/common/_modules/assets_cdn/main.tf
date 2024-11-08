module "assets_cdn" {
  source = "github.com/pagopa/terraform-azurerm-v3//storage_account?ref=v8.27.0"

  name                            = replace(try(local.nonstandard[var.location_short].st, "${var.project}-assets-st-01"), "-", "")
  account_kind                    = "StorageV2"
  account_tier                    = "Standard"
  access_tier                     = "Hot"
  blob_versioning_enabled         = true
  account_replication_type        = "GZRS"
  resource_group_name             = var.resource_group_common
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
  resource_group_name = var.resource_group_assets_cdn
  location            = var.location
  sku                 = "Standard_Microsoft"

  tags = var.tags
}


module "azure_storage_account" {
  source = "github.com/pagopa/dx//infra/modules/azure_storage_account?ref=main"

  environment                          = local.itn_environment
  resource_group_name                  = var.resource_group_common
  tier                                 = "l"
  subnet_pep_id                        = data.azurerm_subnet.subnet_pep_itn.id
  private_dns_zone_resource_group_name = "${local.prefix}-${local.env_short}-rg-common"

  subservices_enabled = {
    blob  = true
    file  = false
    queue = false
    table = false
  }

  blob_features = {
    versioning = true
  }

  force_public_network_access_enabled = true

  static_website = {
    enabled            = true
    index_document     = "index.html"
    error_404_document = "index.html"
  }

  tags = var.tags
}