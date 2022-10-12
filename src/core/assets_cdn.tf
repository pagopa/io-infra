resource "azurerm_resource_group" "assets_cdn_rg" {
  name     = "${local.project}-assets-cdn-rg"
  location = var.location

  tags = var.tags
}

resource "azurerm_cdn_profile" "assets_cdn_profile" {
  name                = "${local.project}-assets-cdn-profile"
  resource_group_name = azurerm_resource_group.assets_cdn_rg.name
  location            = var.location
  sku                 = "Standard_Microsoft"

  tags = var.tags
}

resource "azurerm_cdn_endpoint" "assets_cdn_endpoint" {
  name                          = "${local.project}-assets-cdn-endpoint"
  resource_group_name           = azurerm_resource_group.assets_cdn_rg.name
  location                      = var.location
  profile_name                  = azurerm_cdn_profile.assets_cdn_profile.name
  is_https_allowed              = true
  is_http_allowed               = false
  querystring_caching_behaviour = "IgnoreQueryString"
  origin_host_header            = module.function_assets_cdn.default_hostname

  origin {
    name      = "primary"
    host_name = module.function_assets_cdn.default_hostname
  }

  tags = var.tags
}

resource "azurerm_dns_cname_record" "assets_cdn_io_pagopa_it" {
  name                = "assets.cdn"
  zone_name           = azurerm_dns_zone.io_pagopa_it[0].name
  resource_group_name = azurerm_resource_group.rg_external.name
  ttl                 = var.dns_default_ttl_sec
  record              = azurerm_cdn_endpoint.assets_cdn_endpoint.host_name

  tags = var.tags
}

# TODO enable it
# resource "null_resource" "custom_domain_assets_cdn" {
#   depends_on = [
#     azurerm_cdn_endpoint.assets_cdn_endpoint,
#     azurerm_dns_cname_record.assets_cdn_io_pagopa_it,
#   ]

#   triggers = {
#     resource_group_name = azurerm_resource_group.assets_cdn_rg.name
#     endpoint_name       = azurerm_cdn_endpoint.assets_cdn_endpoint.name
#     endpoint_hostname   = azurerm_cdn_endpoint.assets_cdn_endpoint.host_name
#     endpoint_id         = azurerm_cdn_endpoint.assets_cdn_endpoint.name
#     profile_name        = azurerm_cdn_profile.assets_cdn_profile.name
#     name                = "${azurerm_dns_cname_record.assets_cdn_io_pagopa_it.name}.${join(".", [var.dns_zone_io, var.external_domain])}"
#     hostname            = "${azurerm_dns_cname_record.assets_cdn_io_pagopa_it.name}.${join(".", [var.dns_zone_io, var.external_domain])}"
#   }

#   # https://docs.microsoft.com/it-it/cli/azure/cdn/custom-domain?view=azure-cli-latest
#   provisioner "local-exec" {
#     command = <<EOT
#       az cdn custom-domain create \
#         --resource-group ${self.triggers.resource_group_name} \
#         --endpoint-name ${self.triggers.endpoint_name} \
#         --profile-name ${self.triggers.profile_name} \
#         --name ${replace(self.triggers.name, ".", "-")} \
#         --hostname ${self.triggers.hostname} && \
#       az cdn custom-domain enable-https \
#         --resource-group ${self.triggers.resource_group_name} \
#         --endpoint-name ${self.triggers.endpoint_name} \
#         --profile-name ${self.triggers.profile_name} \
#         --name ${replace(self.triggers.name, ".", "-")} \
#         --min-tls-version "1.2"
#     EOT
#   }

#   # https://docs.microsoft.com/it-it/cli/azure/cdn/custom-domain?view=azure-cli-latest
#   provisioner "local-exec" {
#     when    = destroy
#     command = <<EOT
#       az cdn custom-domain disable-https \
#         --resource-group ${self.triggers.resource_group_name} \
#         --endpoint-name ${self.triggers.endpoint_name} \
#         --profile-name ${self.triggers.profile_name} \
#         --name ${replace(self.triggers.name, ".", "-")} && \
#       az cdn custom-domain delete \
#         --resource-group ${self.triggers.resource_group_name} \
#         --endpoint-name ${self.triggers.endpoint_name} \
#         --profile-name ${self.triggers.profile_name} \
#         --name ${replace(self.triggers.name, ".", "-")}
#     EOT
#   }
# }
