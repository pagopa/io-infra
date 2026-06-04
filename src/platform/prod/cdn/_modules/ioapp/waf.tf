resource "azurerm_cdn_frontdoor_firewall_policy" "ioapp_firewall_policy" {
  name                = "ioapp"
  resource_group_name = var.resource_group_cdn
  sku_name            = "Standard_AzureFrontDoor"

  mode                              = "Prevention"
  enabled                           = true
  custom_block_response_status_code = 403

  custom_rule {
    name     = "RateLimitOutsideEurope"
    priority = 100
    enabled  = true
    type     = "RateLimitRule"
    action   = "Block"

    rate_limit_duration_in_minutes = 5
    rate_limit_threshold           = 200

    match_condition {
      match_variable     = "SocketAddr"
      operator           = "GeoMatch"
      negation_condition = false

      match_values = [
        "PL", "PT", "RO", "SK", "SI", "ES", "SE", "NO", "IS", "LI",
        "DE", "GR", "HU", "IE", "LV", "LT", "LU", "MT", "NL",
        "AT", "BE", "BG", "HR", "CY", "CZ", "DK", "EE", "FI", "FR"
      ]

    }
  }
}

resource "azurerm_cdn_frontdoor_security_policy" "ioapp_frontdoor_security_policy" {
  name                     = "ioapp"
  cdn_frontdoor_profile_id = module.ioapp.id

  security_policies {
    firewall {
      cdn_frontdoor_firewall_policy_id = azurerm_cdn_frontdoor_firewall_policy.ioapp_firewall_policy.id

      association {
        domain {
          cdn_frontdoor_domain_id = module.ioapp.endpoint_id
        }

        # Custom domain IDs not yet exported as output by the DX CDN module

        domain {
          cdn_frontdoor_domain_id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Cdn/profiles/io-p-itn-ioapp-afd-01/customDomains/www-ioapp-it"
        }
        domain {
          cdn_frontdoor_domain_id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Cdn/profiles/io-p-itn-ioapp-afd-01/customDomains/ioapp-it"
        }

        patterns_to_match = ["/*"]
      }
    }
  }
}
