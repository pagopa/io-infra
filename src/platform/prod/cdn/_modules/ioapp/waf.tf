resource "azurerm_cdn_frontdoor_firewall_policy" "ioapp_firewall_policy" {
  name                = "io-p-itn-ioapp-afd-01"
  resource_group_name = var.resource_group_cdn
  sku_name            = "Standard_AzureFrontDoor"

  mode                              = "Detection"
  enabled                           = false
  custom_block_response_body        = ""
  custom_block_response_status_code = 403

  custom_rule {
    name     = "RateLimitOutsideEMEA"
    priority = 100
    enabled  = true
    type     = "RateLimitRule"
    action   = "Block"

    rate_limit_duration_in_minutes = 30
    rate_limit_threshold           = 1000

    match_condition {
      match_variable     = "GeoMatch"
      operator           = "Any"
      negation_condition = true

      match_values = [
        "Italy" # TODO: To be changed to EMEA / list of countries
      ]
    }
  }
}

resource "azurerm_cdn_frontdoor_security_policy" "ioapp_frontdoor_security_policy" {
  name                     = "io-p-itn-ioapp-afd-01"
  cdn_frontdoor_profile_id = module.ioapp.id

  security_policies {
    firewall {
      cdn_frontdoor_firewall_policy_id = azurerm_cdn_frontdoor_firewall_policy.ioapp_firewall_policy.id

      association {
        domain {
          cdn_frontdoor_domain_id = module.ioapp.endpoint_id
        }

        patterns_to_match = ["/*"]
      }
    }
  }
}
