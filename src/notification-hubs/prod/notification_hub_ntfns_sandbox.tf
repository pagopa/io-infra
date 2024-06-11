resource "azurerm_notification_hub_namespace" "sandbox" {
  name                = "${local.legacy_project}-ntfns-sandbox"
  resource_group_name = azurerm_resource_group.notifications.name
  location            = azurerm_resource_group.notifications.location
  namespace_type      = "NotificationHub"
  sku_name            = "Standard"

  tags = local.tags
}

resource "azurerm_notification_hub" "sandbox" {
  name                = "${local.legacy_project}-ntf-sandbox"
  namespace_name      = azurerm_notification_hub_namespace.sandbox.name
  resource_group_name = azurerm_notification_hub_namespace.sandbox.resource_group_name
  location            = azurerm_notification_hub_namespace.sandbox.location

  apns_credential {
    application_mode = "Sandbox"
    bundle_id        = "it.pagopa.app.io"
    team_id          = "M2X5YQ4BJ7"
    key_id           = "3GD7XXZMRW"
    token            = data.azurerm_key_vault_secret.ntfns_common_ntf_common_token_sandbox.value
  }

  gcm_credential {
    api_key = data.azurerm_key_vault_secret.ntfns_common_ntf_common_api_key_sandbox.value
  }

  tags = local.tags
}

resource "azurerm_notification_hub_authorization_rule" "sandbox_default_listen" {
  name                  = "DefaultListenSharedAccessSignature"
  notification_hub_name = azurerm_notification_hub.sandbox.name
  namespace_name        = azurerm_notification_hub_namespace.sandbox.name
  resource_group_name   = azurerm_notification_hub_namespace.sandbox.resource_group_name
  manage                = false
  send                  = false
  listen                = true
}

resource "azurerm_notification_hub_authorization_rule" "sandbox_default_full" {
  name                  = "DefaultFullSharedAccessSignature"
  notification_hub_name = azurerm_notification_hub.sandbox.name
  namespace_name        = azurerm_notification_hub_namespace.sandbox.name
  resource_group_name   = azurerm_notification_hub_namespace.sandbox.resource_group_name
  manage                = true
  send                  = true
  listen                = true
}
