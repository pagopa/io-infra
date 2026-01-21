resource "azurerm_cdn_frontdoor_route" "static_routes" {
  for_each = local.routes

  name                          = each.value.name
  cdn_frontdoor_endpoint_id     = module.azure_cdn.endpoint_id
  cdn_frontdoor_origin_group_id = module.azure_cdn.origin_group_id

  cdn_frontdoor_origin_ids = [
    module.azure_cdn.origin_id # Not exported at the moment
  ]

  cdn_frontdoor_rule_set_ids = [
    module.azure_cdn.rule_set_id
  ]

  cdn_frontdoor_custom_domain_ids = [
    module.azure_cdn.custom_domain_ids # Not exported at the moment
  ]

  patterns_to_match         = [each.value.pattern]
  supported_protocols       = ["Http", "Https"]
  https_redirect_enabled    = true
  cdn_frontdoor_origin_path = each.value.origin_path
}