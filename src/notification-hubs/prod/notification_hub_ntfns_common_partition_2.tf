resource "azurerm_notification_hub_namespace" "common_partition_2" {
  name                = "${local.legacy_project}-ntfns-common-partition-2"
  resource_group_name = data.azurerm_resource_group.weu_common.name
  location            = data.azurerm_resource_group.weu_common.location
  namespace_type      = "NotificationHub"
  sku_name            = "Standard"

  tags = local.tags
}

resource "azurerm_notification_hub" "common_partition_2" {
  name                = "${local.legacy_project}-ntf-common-partition-2"
  namespace_name      = azurerm_notification_hub_namespace.common_partition_2.name
  resource_group_name = azurerm_notification_hub_namespace.common_partition_2.resource_group_name
  location            = azurerm_notification_hub_namespace.common_partition_2.location

  apns_credential {
    application_mode = "Production"
    bundle_id        = "it.pagopa.app.io"
    team_id          = "M2X5YQ4BJ7"
    key_id           = "PL6AXY2HSQ"
    token            = data.azurerm_key_vault_secret.ntfns_common_ntf_common_token.value
  }

  gcm_credential {
    api_key = data.azurerm_key_vault_secret.ntfns_common_ntf_common_api_key.value
  }

  tags = local.tags
}

resource "azurerm_notification_hub_authorization_rule" "common_partition_2_default_listen" {
  name                  = "DefaultListenSharedAccessSignature"
  notification_hub_name = azurerm_notification_hub.common_partition_2.name
  namespace_name        = azurerm_notification_hub_namespace.common_partition_2.name
  resource_group_name   = azurerm_notification_hub_namespace.common_partition_2.resource_group_name
  manage                = false
  send                  = false
  listen                = true
}

resource "azurerm_notification_hub_authorization_rule" "common_partition_2_default_full" {
  name                  = "DefaultFullSharedAccessSignature"
  notification_hub_name = azurerm_notification_hub.common_partition_2.name
  namespace_name        = azurerm_notification_hub_namespace.common_partition_2.name
  resource_group_name   = azurerm_notification_hub_namespace.common_partition_2.resource_group_name
  manage                = true
  send                  = true
  listen                = true
}

resource "azurerm_monitor_metric_alert" "alert_nh_common_partition_2_pns_errors" {

  name                = "[IOCOM|NH2] Push Notification Service errors."
  resource_group_name = azurerm_notification_hub_namespace.common_partition_2.resource_group_name

  scopes              = [azurerm_notification_hub_namespace.common_partition_2.id]
  description         = "Notification Hub Partition 2 incurred in PNS errors, please check. Runbook: not needed."
  severity            = 1
  window_size         = "PT30M"
  frequency           = "PT1M"
  auto_mitigate       = false

  criteria {
    metric_namespace       = "Microsoft.NotificationHubs/namespaces/notificationHubs"
    metric_name            = "outgoing.allpns.pnserror"
    aggregation            = "Sum"
    operator               = "GreaterThan"
    threshold              = 0
    skip_metric_validation = false
  }

  # Action groups for alerts
  action {
    action_group_id = data.azurerm_monitor_action_group.error_action_group.id
  }

  tags = local.tags
}

resource "azurerm_monitor_metric_alert" "alert_nh_common_partition_2_anomalous_pns_success_volume" {

  name                = "[IOCOM|NH2] Push Notification Service anomalous success volume."
  resource_group_name = azurerm_notification_hub_namespace.common_partition_2.resource_group_name

  scopes              = [azurerm_notification_hub_namespace.common_partition_2.id]
  description         = "Notification Hub Partition 2 has an anomalous PNS success volume. Runbook: not needed."
  severity            = 1
  window_size         = "PT30M"
  frequency           = "PT1M"
  auto_mitigate       = false

  criteria {
    metric_namespace       = "Microsoft.NotificationHubs/namespaces/notificationHubs"
    metric_name            = "outgoing.allpns.success"
    aggregation            = "Sum"
    operator               = "GreaterThan"
    threshold              = 30000 # usually we are around 25k under bulk message sending
    skip_metric_validation = false
  }

  # Action groups for alerts
  action {
    action_group_id = data.azurerm_monitor_action_group.error_action_group.id
  }

  tags = local.tags
}
