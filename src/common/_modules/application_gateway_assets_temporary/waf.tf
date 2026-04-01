resource "azurerm_web_application_firewall_policy" "agw" {
  name                = "${var.project}-assets-agw-waf-01"
  resource_group_name = var.resource_group
  location            = var.location

  managed_rules {
    managed_rule_set {
      type    = "OWASP"
      version = "3.2"
    }
    managed_rule_set {
      type    = "Microsoft_BotManagerRuleSet"
      version = "1.1"
    }
  }

  policy_settings {
    request_body_check      = true
    file_upload_enforcement = true
    mode                    = "Detection"
  }

  tags = var.tags
}