data "azurerm_application_insights" "application_insights" {
  name                = "${local.project}-ai-common"
  resource_group_name = "${local.project}-rg-common"
}