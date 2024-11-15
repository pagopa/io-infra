resource "azurerm_resource_group" "io_web_profile_itn_fe_rg" {
  name     = format("%s-ioweb-fe-rg-01", local.project_itn)
  location = local.itn_location
}

module "io_web_profile_itn_fe_st" {
  source = "github.com/pagopa/dx//infra/modules/azure_storage_account?ref=main"

  // s tier -> Standard LRS
  // l tier -> Standard ZRS
  tier = "l"

  # NOTE: domain omitted for characters shortage
  environment = {
    prefix          = var.prefix
    env_short       = var.env_short
    location        = local.itn_location
    app_name        = replace("ioweb-profile", "-", "")
    instance_number = "01"
  }
  access_tier = "Hot"

  resource_group_name                  = azurerm_resource_group.io_web_profile_itn_fe_rg.name
  subnet_pep_id                        = data.azurerm_subnet.private_endpoints_subnet_itn.id
  private_dns_zone_resource_group_name = data.azurerm_resource_group.common_rg_weu.name

  # storage should be accessible by CDN via private endpoint
  # see https://learn.microsoft.com/en-us/azure/frontdoor/standard-premium/how-to-enable-private-link-storage-account
  force_public_network_access_enabled = false
  subservices_enabled = {
    blob = true
  }
  blob_features = {
    versioning = true
    change_feed = {
      enabled = false
    }
    immutability_policy = {
      enabled = false
    }
  }

  static_website = {
    index_document     = "index.html"
    error_404_document = "it/404/index.html"
  }

  tags = var.tags
}
