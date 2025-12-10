resource "azurerm_cdn_frontdoor_route" "static_routes" {
  for_each = local.routes

  name                          = each.value.name
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.cdn_endpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.primary_origin_group.id

  cdn_frontdoor_origin_ids = [
    azurerm_cdn_frontdoor_origin.primary_origin.id
  ]

  cdn_frontdoor_rule_set_ids = [
    azurerm_cdn_frontdoor_rule_set.primary_ruleset.id
  ]

  patterns_to_match         = [each.value.pattern]
  supported_protocols       = ["Http", "Https"]
  https_redirect_enabled    = true
  cdn_frontdoor_origin_path = each.value.origin_path
}