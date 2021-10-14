data "azurerm_api_management" "apim" {
  name                = format("%s-apim-api", local.project)
  resource_group_name = format("%s-rg-internal", local.project)
}
