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

# APIM in ITN
data "azurerm_api_management" "apim_itn_api" {
  name                = local.apim_itn_name
  resource_group_name = local.apim_itn_resource_group_name
}
