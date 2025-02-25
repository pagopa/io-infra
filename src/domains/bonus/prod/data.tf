data "azuread_group" "admin" {
  display_name = "${local.prefix}-${local.env_short}-adgroup-admin"
}
