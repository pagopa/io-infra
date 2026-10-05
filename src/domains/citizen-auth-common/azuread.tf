# Azure AD
data "azuread_group" "adgroup_admin" {
  display_name = format("%s-adgroup-admin", local.product)
}

data "azuread_group" "adgroup_developers" {
  display_name = format("%s-adgroup-developers", local.product)
}

data "azuread_group" "adgroup_auth_admins" {
  display_name = format("%s-adgroup-auth-admins", local.product)
}
