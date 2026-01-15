resource "azurerm_api_management_named_value" "session_manager_introspection_url" {
  name                = "session-manager-introspection-url"
  resource_group_name = var.resource_group_internal
  api_management_name = module.platform_api_gateway.name
  display_name        = "session-manager-introspection-url"
  value               = "/api/auth/v1/user-identity"
}

resource "azurerm_api_management_named_value" "platform_api_gateway_hostname_internal" {
  name                = "platform-api-gateway-hostname-internal"
  resource_group_name = var.resource_group_internal
  api_management_name = module.platform_api_gateway.name
  display_name        = "platform-api-gateway-hostname-internal"
  value               = "proxy.internal.io.pagopa.it"
}
