resource "azurerm_role_assignment" "appbackend_adgroup_wallet_admins" {
  role_definition_name = "Contributor"
  scope                = module.appservice_app_backend.id
  principal_id         = var.azure_adgroup_wallet_admins_object_id
}

resource "azurerm_role_assignment" "appbackend_adgroup_com_admins" {
  role_definition_name = "Contributor"
  scope                = module.appservice_app_backend.id
  principal_id         = var.azure_adgroup_com_admins_object_id
}

resource "azurerm_role_assignment" "appbackend_adgroup_svc_admins" {
  role_definition_name = "Contributor"
  scope                = module.appservice_app_backend.id
  principal_id         = var.azure_adgroup_svc_admins_object_id
}

resource "azurerm_role_assignment" "appbackend_adgroup_auth_admins" {
  role_definition_name = "Contributor"
  scope                = module.appservice_app_backend.id
  principal_id         = var.azure_adgroup_auth_admins_object_id
}

resource "azurerm_role_assignment" "appbackend_adgroup_bonus_admins" {
  role_definition_name = "Contributor"
  scope                = module.appservice_app_backend.id
  principal_id         = var.azure_adgroup_bonus_admins_object_id
}

resource "azurerm_role_assignment" "appbackend_staging_adgroup_wallet_admins" {
  role_definition_name = "Contributor"
  scope                = module.appservice_app_backend_slot_staging.id
  principal_id         = var.azure_adgroup_wallet_admins_object_id
}

resource "azurerm_role_assignment" "appbackend_staging_adgroup_com_admins" {
  role_definition_name = "Contributor"
  scope                = module.appservice_app_backend_slot_staging.id
  principal_id         = var.azure_adgroup_com_admins_object_id
}

resource "azurerm_role_assignment" "appbackend_staging_adgroup_svc_admins" {
  role_definition_name = "Contributor"
  scope                = module.appservice_app_backend_slot_staging.id
  principal_id         = var.azure_adgroup_svc_admins_object_id
}

resource "azurerm_role_assignment" "appbackend_staging_adgroup_auth_admins" {
  role_definition_name = "Contributor"
  scope                = module.appservice_app_backend_slot_staging.id
  principal_id         = var.azure_adgroup_auth_admins_object_id
}

resource "azurerm_role_assignment" "appbackend_staging_adgroup_bonus_admins" {
  role_definition_name = "Contributor"
  scope                = module.appservice_app_backend_slot_staging.id
  principal_id         = var.azure_adgroup_bonus_admins_object_id
}
