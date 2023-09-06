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

resource "azurerm_role_assignment" "firmaconio_selfcare_apim_contributor_role" {
  scope                = module.apim.id
  role_definition_name = "Contributor"
  principal_id         = data.azurerm_linux_web_app.firmaconio_selfcare_web_app.identity.principal_id
}