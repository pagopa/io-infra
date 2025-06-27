resource "azurerm_web_application_firewall_policy" "app" {
  name                = "${var.project}-agw-api-app-waf-01"
  resource_group_name = var.resource_group_common
  location            = var.location

  policy_settings {
    enabled                     = true
    mode                        = "Prevention"
    request_body_check          = true
    file_upload_limit_in_mb     = 100
    max_request_body_size_in_kb = 128
  }

  managed_rules {

    managed_rule_set {
      type    = "OWASP"
      version = "3.1"

      rule_group_override {
        rule_group_name = "REQUEST-913-SCANNER-DETECTION"
        rule {
          id      = "913100"
          enabled = false
        }
        rule {
          id      = "913101"
          enabled = false
        }
        rule {
          id      = "913102"
          enabled = false
        }
        rule {
          id      = "913110"
          enabled = false
        }
        rule {
          id      = "913120"
          enabled = false
        }
      }

      rule_group_override {
        rule_group_name = "REQUEST-920-PROTOCOL-ENFORCEMENT"
        rule {
          id      = "920300"
          enabled = false
        }
        rule {
          id      = "920320"
          enabled = false
        }
      }

      rule_group_override {
        rule_group_name = "REQUEST-930-APPLICATION-ATTACK-LFI"
        rule {
          id      = "930120"
          enabled = false
        }
      }

      rule_group_override {
        rule_group_name = "REQUEST-931-APPLICATION-ATTACK-RFI"
        rule {
          id      = "931130"
          enabled = false
        }
      }

      rule_group_override {
        rule_group_name = "REQUEST-932-APPLICATION-ATTACK-RCE"
        rule {
          id      = "932150"
          enabled = false
        }
      }

      rule_group_override {
        rule_group_name = "REQUEST-941-APPLICATION-ATTACK-XSS"
        rule {
          id      = "941130"
          enabled = false
        }
      }

      rule_group_override {
        rule_group_name = "REQUEST-942-APPLICATION-ATTACK-SQLI"
        rule {
          id      = "942100"
          enabled = false
        }
        rule {
          id      = "942120"
          enabled = false
        }
        rule {
          id      = "942190"
          enabled = false
        }
        rule {
          id      = "942200"
          enabled = false
        }
        rule {
          id      = "942210"
          enabled = false
        }
        rule {
          id      = "942240"
          enabled = false
        }
        rule {
          id      = "942250"
          enabled = false
        }
        rule {
          id      = "942260"
          enabled = false
        }
        rule {
          id      = "942330"
          enabled = false
        }
        rule {
          id      = "942340"
          enabled = false
        }
        rule {
          id      = "942370"
          enabled = false
        }
        rule {
          id      = "942380"
          enabled = false
        }
        rule {
          id      = "942430"
          enabled = false
        }
        rule {
          id      = "942440"
          enabled = false
        }
        rule {
          id      = "942450"
          enabled = false
        }
      }

    }
  }

  tags = var.tags
}
