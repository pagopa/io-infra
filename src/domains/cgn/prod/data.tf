data "azuread_group" "bonus_admins" {
  display_name = "${local.prefix}-${local.env_short}-adgroup-bonus-admins"
}
