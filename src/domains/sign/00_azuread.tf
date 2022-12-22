# Azure AD
data "azuread_group" "adgroup_admin" {
  display_name = format("%s-adgroup-admin", local.product)
}

data "azuread_group" "adgroup_contributors" {
  display_name = format("%s-adgroup-contributors", local.product)
}

data "azuread_group" "adgroup_developers" {
  display_name = format("%s-adgroup-developers", local.product)
}

# Unused at the moment
# data "azuread_group" "adgroup_externals" {
#   display_name = format("%s-adgroup-externals", local.product)
# }

# Unused at the moment
# data "azuread_group" "adgroup_security" {
#   display_name = format("%s-adgroup-security", local.product)
# }

data "azuread_group" "adgroup_sign" {
  display_name = format("%s-adgroup-sign", local.product)
}
