resource "azurerm_resource_group" "assets_cdn_rg" {
  name     = "${local.project}-assets-cdn-rg"
  location = var.location
  tags     = var.tags
}

resource "azurerm_cdn_profile" "assets_cdn_profile" {
  name                = "${local.project}-assets-cdn-profile"
  resource_group_name = azurerm_resource_group.assets_cdn_rg.name
  location            = var.location
  sku                 = "Standard_Microsoft"
  tags                = var.tags
}

resource "azurerm_cdn_endpoint" "assets_cdn_endpoint" {
  name                          = "${local.project}-assets-cdn-endpoint"
  resource_group_name           = azurerm_resource_group.assets_cdn_rg.name
  location                      = var.location
  profile_name                  = azurerm_cdn_profile.assets_cdn_profile.name
  is_https_allowed              = true
  is_http_allowed               = false
  querystring_caching_behaviour = "IgnoreQueryString"
  origin_host_header            = module.function_cdn_assets.default_hostname

  origin {
    name      = "primary"
    host_name = module.function_cdn_assets.default_hostname
  }

  tags = var.tags
}


