data "azurerm_application_insights" "application_insights" {
  name                = "io-p-ai-common"
  resource_group_name = "io-p-rg-common"
}
