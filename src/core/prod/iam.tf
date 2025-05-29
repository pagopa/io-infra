resource "azurerm_role_assignment" "dashboards_com_admins" {
  scope                = azurerm_resource_group.dashboards_weu.id
  principal_id         = data.azuread_group.com_admins.object_id
  role_definition_name = "PagoPA Opex Dashboards Contributor"
  description          = "Allow IO COM admins to manage dashboards"
}

resource "azurerm_role_assignment" "dashboards_com_devs" {
  scope                = azurerm_resource_group.dashboards_weu.id
  principal_id         = data.azuread_group.com_devs.object_id
  role_definition_name = "PagoPA Opex Dashboards Contributor"
  description          = "Allow IO COM devs to manage dashboards"
}

resource "azurerm_role_assignment" "dashboards_svc_admins" {
  scope                = azurerm_resource_group.dashboards_weu.id
  principal_id         = data.azuread_group.svc_admins.object_id
  role_definition_name = "PagoPA Opex Dashboards Contributor"
  description          = "Allow IO SVC admins to manage dashboards"
}

resource "azurerm_role_assignment" "dashboards_svc_devs" {
  scope                = azurerm_resource_group.dashboards_weu.id
  principal_id         = data.azuread_group.svc_devs.object_id
  role_definition_name = "PagoPA Opex Dashboards Contributor"
  description          = "Allow IO SVC devs to manage dashboards"
}

resource "azurerm_role_assignment" "dashboards_auth_admins" {
  scope                = azurerm_resource_group.dashboards_weu.id
  principal_id         = data.azuread_group.auth_admins.object_id
  role_definition_name = "PagoPA Opex Dashboards Contributor"
  description          = "Allow IO Auth admins to manage dashboards"
}

resource "azurerm_role_assignment" "dashboards_auth_devs" {
  scope                = azurerm_resource_group.dashboards_weu.id
  principal_id         = data.azuread_group.auth_devs.object_id
  role_definition_name = "PagoPA Opex Dashboards Contributor"
  description          = "Allow IO Auth admins to manage dashboards"
}

resource "azurerm_role_assignment" "dashboards_bonus_admins" {
  scope                = azurerm_resource_group.dashboards_weu.id
  principal_id         = data.azuread_group.bonus_admins.object_id
  role_definition_name = "PagoPA Opex Dashboards Contributor"
  description          = "Allow IO Bonus admins to manage dashboards"
}

resource "azurerm_role_assignment" "dashboards_bonus_devs" {
  scope                = azurerm_resource_group.dashboards_weu.id
  principal_id         = data.azuread_group.bonus_devs.object_id
  role_definition_name = "PagoPA Opex Dashboards Contributor"
  description          = "Allow IO Bonus devs to manage dashboards"
}

resource "azurerm_role_assignment" "dashboards_wallet_admins" {
  scope                = azurerm_resource_group.dashboards_weu.id
  principal_id         = data.azuread_group.wallet_admins.object_id
  role_definition_name = "PagoPA Opex Dashboards Contributor"
  description          = "Allow IO Wallet admins to manage dashboards"
}

resource "azurerm_role_assignment" "dashboards_wallet_devs" {
  scope                = azurerm_resource_group.dashboards_weu.id
  principal_id         = data.azuread_group.wallet_devs.object_id
  role_definition_name = "PagoPA Opex Dashboards Contributor"
  description          = "Allow IO Wallet devs to manage dashboards"
}
