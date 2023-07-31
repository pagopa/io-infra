locals {
  firmaconio = {
    project = format("%s-sign", local.project)
    resource_group_names = {
      backend = format("%s-backend-rg", local.firmaconio.project)
    }
  }
}


data "azurerm_linux_web_app" "firmaconio_selfcare_web_app" {
  name = format("%s-backoffice-app", local.firmaconio.project)
  resource_group_name = local.firmaconio.resource_group_names.backend
}