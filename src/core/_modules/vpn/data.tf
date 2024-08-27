data "azuread_application" "vpn_app" {
  display_name = "${var.prefix}-${var.env_short}-app-vpn"
}
