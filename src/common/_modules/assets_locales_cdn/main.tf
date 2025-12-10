module "cdn_storage" {
  source  = "pagopa-dx/azure-storage-account/azurerm"
  version = "~> 2.0.0"

  resource_group_name = var.resource_group_common

  environment = {
    prefix          = var.prefix
    env_short       = var.env_short
    location        = var.location
    app_name        = replace("${var.project}-assets-st", "-", "")
    instance_number = "01"
  }

  access_tier = "Hot"

  blob_features = {
    versioning = true
  }

  force_public_network_access_enabled = true

  tags = var.tags
}

resource "azurerm_cdn_frontdoor_profile" "cdn_profile" {
  name                     = "${var.project}-assets-cdnp-01"
  resource_group_name      = var.resource_group_assets_cdn
  sku_name                 = "Standard_AzureFrontDoor"
  response_timeout_seconds = 120 # Set to default

  tags = var.tags
}
