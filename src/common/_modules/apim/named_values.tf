resource "azurerm_api_management_named_value" "session_manager_baseurl" {
  name                = "session-manager-baseurl"
  resource_group_name = var.resource_group_internal
  api_management_name = try(local.nonstandard[var.location_short].apim_name, "${var.project}-apim-01")
  display_name        = "session-manager-baseurl"
  value               = data.azurerm_linux_web_app.session_manager_app_weu.default_hostname
}

resource "azurerm_api_management_named_value" "session_manager_introspection_url" {
  name                = "session-manager-introspection-url"
  resource_group_name = var.resource_group_internal
  api_management_name = try(local.nonstandard[var.location_short].apim_name, "${var.project}-apim-01")
  display_name        = "session-manager-introspection-url"
  value               = "/api/v1/user-identity"
}

