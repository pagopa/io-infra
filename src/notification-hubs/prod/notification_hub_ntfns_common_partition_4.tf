resource "azurerm_notification_hub_namespace" "common_partition_4" {
  name                = "${local.legacy_project}-ntfns-common-partition-4"
  resource_group_name = data.azurerm_resource_group.weu_common.name
  location            = data.azurerm_resource_group.weu_common.location
  namespace_type      = "NotificationHub"
  sku_name            = "Standard"

  tags = local.tags
}

resource "azurerm_notification_hub" "common_partition_4" {
  name                = "${local.legacy_project}-ntf-common-partition-4"
  namespace_name      = azurerm_notification_hub_namespace.common_partition_4.name
  resource_group_name = azurerm_notification_hub_namespace.common_partition_4.resource_group_name
  location            = azurerm_notification_hub_namespace.common_partition_4.location

  apns_credential {
    application_mode = "Production"
    bundle_id        = "it.pagopa.app.io"
    team_id          = "M2X5YQ4BJ7"
    key_id           = "93886R7JP5"
    token            = data.azurerm_key_vault_secret.ntfns_common_ntf_common_token.value
  }

  gcm_credential {
    api_key = data.azurerm_key_vault_secret.ntfns_common_ntf_common_api_key.value
  }

  tags = local.tags
}

resource "azurerm_notification_hub_authorization_rule" "common_partition_4_default_listen" {
  name                  = "DefaultListenSharedAccessSignature"
  notification_hub_name = azurerm_notification_hub.common_partition_4.name
  namespace_name        = azurerm_notification_hub_namespace.common_partition_4.name
  resource_group_name   = azurerm_notification_hub_namespace.common_partition_4.resource_group_name
  manage                = false
  send                  = false
  listen                = true
}

resource "azurerm_notification_hub_authorization_rule" "common_partition_4_default_full" {
  name                  = "DefaultFullSharedAccessSignature"
  notification_hub_name = azurerm_notification_hub.common_partition_4.name
  namespace_name        = azurerm_notification_hub_namespace.common_partition_4.name
  resource_group_name   = azurerm_notification_hub_namespace.common_partition_4.resource_group_name
  manage                = true
  send                  = true
  listen                = true
}
