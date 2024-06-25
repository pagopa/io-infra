resource "azurerm_notification_hub_namespace" "common_partition_3" {
  name                = "${local.legacy_project}-ntfns-common-partition-3"
  resource_group_name = data.azurerm_resource_group.weu_common.name
  location            = data.azurerm_resource_group.weu_common.location
  namespace_type      = "NotificationHub"
  sku_name            = "Standard"

  tags = local.tags
}

resource "azurerm_notification_hub" "common_partition_3" {
  name                = "${local.legacy_project}-ntf-common-partition-3"
  namespace_name      = azurerm_notification_hub_namespace.common_partition_3.name
  resource_group_name = azurerm_notification_hub_namespace.common_partition_3.resource_group_name
  location            = azurerm_notification_hub_namespace.common_partition_3.location

  apns_credential {
    application_mode = local.apns_credential.application_mode
    bundle_id        = local.apns_credential.bundle_id
    team_id          = local.apns_credential.team_id
    key_id           = local.apns_credential.key_id
    token            = data.azurerm_key_vault_secret.ntfns_common_ntf_common_token.value
  }

  gcm_credential {
    api_key = data.azurerm_key_vault_secret.ntfns_common_ntf_common_api_key.value
  }

  tags = local.tags
}

resource "azurerm_notification_hub_authorization_rule" "common_partition_3_default_listen" {
  name                  = "DefaultListenSharedAccessSignature"
  notification_hub_name = azurerm_notification_hub.common_partition_3.name
  namespace_name        = azurerm_notification_hub_namespace.common_partition_3.name
  resource_group_name   = azurerm_notification_hub_namespace.common_partition_3.resource_group_name
  manage                = false
  send                  = false
  listen                = true
}

resource "azurerm_notification_hub_authorization_rule" "common_partition_3_default_full" {
  name                  = "DefaultFullSharedAccessSignature"
  notification_hub_name = azurerm_notification_hub.common_partition_3.name
  namespace_name        = azurerm_notification_hub_namespace.common_partition_3.name
  resource_group_name   = azurerm_notification_hub_namespace.common_partition_3.resource_group_name
  manage                = true
  send                  = true
  listen                = true
}

resource "azurerm_monitor_metric_alert" "alert_nh_common_partition_3_pns_errors" {

  name                = "[IOCOM|NH3] Push Notification Service errors"
  resource_group_name = azurerm_notification_hub_namespace.common_partition_3.resource_group_name

  scopes        = [azurerm_notification_hub.common_partition_3.id]
  description   = "Notification Hub Partition 3 incurred in PNS errors, please check. Runbook: not needed."
  severity      = 1
  window_size   = "PT5M"
  frequency     = "PT1M"
  auto_mitigate = false

  criteria {
    metric_namespace       = "Microsoft.NotificationHubs/namespaces/notificationHubs"
    metric_name            = "outgoing.allpns.pnserror"
    aggregation            = "Total"
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

resource "azurerm_monitor_metric_alert" "alert_nh_common_partition_3_anomalous_pns_success_volume" {

  name                = "[IOCOM|NH3] Push Notification Service anomalous success volume"
  resource_group_name = azurerm_notification_hub_namespace.common_partition_3.resource_group_name

  scopes        = [azurerm_notification_hub.common_partition_3.id]
  description   = "Notification Hub Partition 3 has an anomalous PNS success volume. Runbook: not needed."
  severity      = 1
  window_size   = "PT5M"
  frequency     = "PT1M"
  auto_mitigate = false

  dynamic_criteria {
    metric_namespace         = "Microsoft.NotificationHubs/namespaces/notificationHubs"
    metric_name              = "outgoing.allpns.success"
    aggregation              = "Total"
    operator                 = "GreaterThan"
    alert_sensitivity        = "High"
    evaluation_total_count   = 1
    evaluation_failure_count = 1
    skip_metric_validation   = false
  }

  # Action groups for alerts
  action {
    action_group_id = data.azurerm_monitor_action_group.error_action_group.id
  }

  tags = local.tags
}
