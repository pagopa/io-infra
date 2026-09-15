module "cdn_storage" {
  source  = "pagopa-dx/azure-storage-account/azurerm"
  version = "~> 2.0.0"

  resource_group_name = var.resource_group_common

  environment = {
    prefix          = var.prefix
    env_short       = var.env_short
    location        = var.location
    app_name        = "assets"
    instance_number = "01"
  }

  access_tier = "Hot"

  blob_features = {
    versioning = true
  }

  static_website = {
    enabled            = true
    index_document     = "index.html"
    error_404_document = "index.html"
  }

  force_public_network_access_enabled = true

  tags = var.tags
}