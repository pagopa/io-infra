locals {
  firmaconio_project = format("%s-sign", local.project)
  firmaconio = {
    resource_group_names = {
      backend = format("%s-backend-rg", local.firmaconio_project)
    }
  }
}


data "azurerm_linux_web_app" "firmaconio_selfcare_web_app" {
  name                = format("%s-backoffice-app", local.firmaconio_project)
  resource_group_name = local.firmaconio.resource_group_names.backend
}