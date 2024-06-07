resource "azurerm_notification_hub_namespace" "common" {
  name                = "${local.legacy_project}-ntfns-common"
  resource_group_name = data.azurerm_resource_group.weu_common.name
  location            = data.azurerm_resource_group.weu_common.location
  namespace_type      = "NotificationHub"
  sku_name            = "Standard"

  tags = local.tags
}

resource "azurerm_notification_hub" "common" {
  name                = "${local.legacy_project}-ntf-common"
  namespace_name      = azurerm_notification_hub_namespace.common.name
  resource_group_name = data.azurerm_resource_group.weu_common.name
  location            = data.azurerm_resource_group.weu_common.location

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

resource "azurerm_notification_hub" "common01" {
  name                = "${local.legacy_project}-ntf-common01"
  namespace_name      = azurerm_notification_hub_namespace.common.name
  resource_group_name = data.azurerm_resource_group.weu_common.name
  location            = data.azurerm_resource_group.weu_common.location

  tags = local.tags
}
