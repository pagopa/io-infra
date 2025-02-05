data "azurerm_application_insights" "application_insights" {
  name                = "${local.project}-ai-common"
  resource_group_name = "${local.project}-rg-common"
}

data "azuread_group" "svc_admins" {
  display_name = "${local.project}-adgroup-svc-admins"
}

data "azuread_group" "svc_devs" {
  display_name = "${local.project}-adgroup-svc-developers"
}