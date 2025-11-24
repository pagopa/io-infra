resource "azurerm_cdn_frontdoor_route" "abi_logos" {
  name                          = "abi-logos-route"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.cdn_endpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.primary_origin_group.id

  cdn_frontdoor_origin_ids = [
    azurerm_cdn_frontdoor_origin.primary_origin.id
  ]

  cdn_frontdoor_rule_set_ids = [azurerm_cdn_frontdoor_rule_set.primary_ruleset.id]

  patterns_to_match         = ["/logos/abi/*"]
  supported_protocols       = ["Http", "Https"]
  https_redirect_enabled    = true
  cdn_frontdoor_origin_path = "/logos/abi"
}

resource "azurerm_cdn_frontdoor_route" "app_logos" {
  name                          = "app-logos-route"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.cdn_endpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.primary_origin_group.id

  cdn_frontdoor_origin_ids = [
    azurerm_cdn_frontdoor_origin.primary_origin.id
  ]

  cdn_frontdoor_rule_set_ids = [azurerm_cdn_frontdoor_rule_set.primary_ruleset.id]

  patterns_to_match         = ["/logos/apps/*"]
  supported_protocols       = ["Http", "Https"]
  https_redirect_enabled    = true
  cdn_frontdoor_origin_path = "/logos/apps"
}

resource "azurerm_cdn_frontdoor_route" "assistance_tools" {
  name                          = "assistance-tools-route"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.cdn_endpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.primary_origin_group.id

  cdn_frontdoor_origin_ids = [
    azurerm_cdn_frontdoor_origin.primary_origin.id
  ]

  cdn_frontdoor_rule_set_ids = [azurerm_cdn_frontdoor_rule_set.primary_ruleset.id]

  patterns_to_match         = ["/assistanceTools/*"]
  supported_protocols       = ["Http", "Https"]
  https_redirect_enabled    = true
  cdn_frontdoor_origin_path = "/assistanceTools"
}

resource "azurerm_cdn_frontdoor_route" "bonus" {
  name                          = "bonus-route"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.cdn_endpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.primary_origin_group.id

  cdn_frontdoor_origin_ids = [
    azurerm_cdn_frontdoor_origin.primary_origin.id
  ]

  cdn_frontdoor_rule_set_ids = [azurerm_cdn_frontdoor_rule_set.primary_ruleset.id]

  patterns_to_match         = ["/bonus/*"]
  supported_protocols       = ["Http", "Https"]
  https_redirect_enabled    = true
  cdn_frontdoor_origin_path = "/bonus"
}

resource "azurerm_cdn_frontdoor_route" "contextualhelp" {
  name                          = "contextualhelp-route"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.cdn_endpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.primary_origin_group.id

  cdn_frontdoor_origin_ids = [
    azurerm_cdn_frontdoor_origin.primary_origin.id
  ]

  cdn_frontdoor_rule_set_ids = [azurerm_cdn_frontdoor_rule_set.primary_ruleset.id]

  patterns_to_match         = ["/contextualhelp/*"]
  supported_protocols       = ["Http", "Https"]
  https_redirect_enabled    = true
  cdn_frontdoor_origin_path = "/contextualhelp"
}

resource "azurerm_cdn_frontdoor_route" "email_assets" {
  name                          = "email-assets-route"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.cdn_endpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.primary_origin_group.id

  cdn_frontdoor_origin_ids = [
    azurerm_cdn_frontdoor_origin.primary_origin.id
  ]

  cdn_frontdoor_rule_set_ids = [azurerm_cdn_frontdoor_rule_set.primary_ruleset.id]

  patterns_to_match         = ["/email-assets/*"]
  supported_protocols       = ["Http", "Https"]
  https_redirect_enabled    = true
  cdn_frontdoor_origin_path = "/email-assets"
}

resource "azurerm_cdn_frontdoor_route" "eucovidcert_logos" {
  name                          = "eucovidcert-logos-route"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.cdn_endpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.primary_origin_group.id

  cdn_frontdoor_origin_ids = [
    azurerm_cdn_frontdoor_origin.primary_origin.id
  ]

  cdn_frontdoor_rule_set_ids = [azurerm_cdn_frontdoor_rule_set.primary_ruleset.id]

  patterns_to_match         = ["/logos/eucovidcert/*"]
  supported_protocols       = ["Http", "Https"]
  https_redirect_enabled    = true
  cdn_frontdoor_origin_path = "/logos/eucovidcert"
}

resource "azurerm_cdn_frontdoor_route" "html" {
  name                          = "html-route"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.cdn_endpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.primary_origin_group.id

  cdn_frontdoor_origin_ids = [
    azurerm_cdn_frontdoor_origin.primary_origin.id
  ]

  cdn_frontdoor_rule_set_ids = [azurerm_cdn_frontdoor_rule_set.primary_ruleset.id]

  patterns_to_match         = ["/html/*"]
  supported_protocols       = ["Http", "Https"]
  https_redirect_enabled    = true
  cdn_frontdoor_origin_path = "/html"
}

resource "azurerm_cdn_frontdoor_route" "locales" {
  name                          = "locales-route"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.cdn_endpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.primary_origin_group.id

  cdn_frontdoor_origin_ids = [
    azurerm_cdn_frontdoor_origin.primary_origin.id
  ]

  cdn_frontdoor_rule_set_ids = [azurerm_cdn_frontdoor_rule_set.primary_ruleset.id]

  patterns_to_match         = ["/locales/*"]
  supported_protocols       = ["Http", "Https"]
  https_redirect_enabled    = true
  cdn_frontdoor_origin_path = "/locales"
}

resource "azurerm_cdn_frontdoor_route" "municipalities" {
  name                          = "municipalities-route"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.cdn_endpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.primary_origin_group.id

  cdn_frontdoor_origin_ids = [
    azurerm_cdn_frontdoor_origin.primary_origin.id
  ]

  cdn_frontdoor_rule_set_ids = [azurerm_cdn_frontdoor_rule_set.primary_ruleset.id]

  patterns_to_match         = ["/municipalities/*"]
  supported_protocols       = ["Http", "Https"]
  https_redirect_enabled    = true
  cdn_frontdoor_origin_path = "/municipalities"
}

resource "azurerm_cdn_frontdoor_route" "organization_logos" {
  name                          = "organization-logos-route"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.cdn_endpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.primary_origin_group.id

  cdn_frontdoor_origin_ids = [
    azurerm_cdn_frontdoor_origin.primary_origin.id
  ]

  cdn_frontdoor_rule_set_ids = [azurerm_cdn_frontdoor_rule_set.primary_ruleset.id]

  patterns_to_match         = ["/logos/organizations/*"]
  supported_protocols       = ["Http", "Https"]
  https_redirect_enabled    = true
  cdn_frontdoor_origin_path = "/services"
}

resource "azurerm_cdn_frontdoor_route" "privative_logos" {
  name                          = "privative-logos-route"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.cdn_endpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.primary_origin_group.id

  cdn_frontdoor_origin_ids = [
    azurerm_cdn_frontdoor_origin.primary_origin.id
  ]

  cdn_frontdoor_rule_set_ids = [azurerm_cdn_frontdoor_rule_set.primary_ruleset.id]

  patterns_to_match         = ["/logos/privative/*"]
  supported_protocols       = ["Http", "Https"]
  https_redirect_enabled    = true
  cdn_frontdoor_origin_path = "/logos/privative"
}

resource "azurerm_cdn_frontdoor_route" "service_logos" {
  name                          = "service-logos-route"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.cdn_endpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.primary_origin_group.id

  cdn_frontdoor_origin_ids = [
    azurerm_cdn_frontdoor_origin.primary_origin.id
  ]

  cdn_frontdoor_rule_set_ids = [azurerm_cdn_frontdoor_rule_set.primary_ruleset.id]

  patterns_to_match         = ["/logos/services/*"]
  supported_protocols       = ["Http", "Https"]
  https_redirect_enabled    = true
  cdn_frontdoor_origin_path = "/services"
}

resource "azurerm_cdn_frontdoor_route" "services_webview" {
  name                          = "services-webview-route"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.cdn_endpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.primary_origin_group.id

  cdn_frontdoor_origin_ids = [
    azurerm_cdn_frontdoor_origin.primary_origin.id
  ]

  cdn_frontdoor_rule_set_ids = [azurerm_cdn_frontdoor_rule_set.primary_ruleset.id]

  patterns_to_match         = ["/services-webview/*"]
  supported_protocols       = ["Http", "Https"]
  https_redirect_enabled    = true
  cdn_frontdoor_origin_path = "/services/services-webview"
}

resource "azurerm_cdn_frontdoor_route" "sign" {
  name                          = "sign-route"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.cdn_endpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.primary_origin_group.id

  cdn_frontdoor_origin_ids = [
    azurerm_cdn_frontdoor_origin.primary_origin.id
  ]

  cdn_frontdoor_rule_set_ids = [azurerm_cdn_frontdoor_rule_set.primary_ruleset.id]

  patterns_to_match         = ["/sign/*"]
  supported_protocols       = ["Http", "Https"]
  https_redirect_enabled    = true
  cdn_frontdoor_origin_path = "/sign"
}

resource "azurerm_cdn_frontdoor_route" "spid_idps" {
  name                          = "spid-idps-route"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.cdn_endpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.primary_origin_group.id

  cdn_frontdoor_origin_ids = [
    azurerm_cdn_frontdoor_origin.primary_origin.id
  ]

  cdn_frontdoor_rule_set_ids = [azurerm_cdn_frontdoor_rule_set.primary_ruleset.id]

  patterns_to_match         = ["/spid/idps/*"]
  supported_protocols       = ["Http", "Https"]
  https_redirect_enabled    = true
  cdn_frontdoor_origin_path = "/spid/idps"
}