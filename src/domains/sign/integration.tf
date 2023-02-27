module "event_hub" {
  source                   = "git::https://github.com/pagopa/azurerm.git//eventhub?ref=v2.18.7"
  name                     = format("%s-eventhub-ns", local.project)
  location                 = azurerm_resource_group.integration_rg.location
  resource_group_name      = azurerm_resource_group.integration_rg.name
  auto_inflate_enabled     = var.integration_hub.auto_inflate_enabled
  sku                      = var.integration_hub.sku_name
  capacity                 = var.integration_hub.capacity
  maximum_throughput_units = var.integration_hub.maximum_throughput_units
  zone_redundant           = var.integration_hub.zone_redundant

  virtual_network_ids = [data.azurerm_virtual_network.vnet_common.id]
  subnet_id           = module.io_sign_eventhub_snet.id

  private_dns_zone_record_A_name = null

  eventhubs = var.integration_hub.hubs

  network_rulesets = [
    {
      default_action       = "Deny",
      virtual_network_rule = [],
      ip_rule              = var.integration_hub.ip_rules
    }
  ]

  private_dns_zones = {
    id   = [data.azurerm_private_dns_zone.privatelink_servicebus_windows_net.id]
    name = [data.azurerm_private_dns_zone.privatelink_servicebus_windows_net.name]
  }

  alerts_enabled = var.integration_hub.alerts_enabled
  metric_alerts = {
    no_trx = {
      aggregation = "Total"
      metric_name = "IncomingMessages"
      description = "No transactions received from acquirer in the last 24h"
      operator    = "LessThanOrEqual"
      threshold   = 1000
      frequency   = "PT1H"
      window_size = "P1D"
      dimension = [
        {
          name     = "EntityName"
          operator = "Include"
          values   = ["rtd-trx"]
        }
      ],
    },
    active_connections = {
      aggregation = "Average"
      metric_name = "ActiveConnections"
      description = null
      operator    = "LessThanOrEqual"
      threshold   = 0
      frequency   = "PT5M"
      window_size = "PT15M"
      dimension   = [],
    },
    error_trx = {
      aggregation = "Total"
      metric_name = "IncomingMessages"
      description = "Transactions rejected from one acquirer file received. trx write on eventhub. check immediately"
      operator    = "GreaterThan"
      threshold   = 0
      frequency   = "PT5M"
      window_size = "PT30M"
      dimension = [
        {
          name     = "EntityName"
          operator = "Include"
          values = [
            "bpd-trx-error",
            "rtd-trx-error"
          ]
        }
      ],
    },
  }

  action = [
    {
      action_group_id    = data.azurerm_monitor_action_group.slack.id
      webhook_properties = null
    },
    {
      action_group_id    = data.azurerm_monitor_action_group.email.id
      webhook_properties = null
    }
  ]

  tags = var.tags
}

# TODO remove
resource "azurerm_eventhub_namespace_authorization_rule" "integration_event_hub_keys" {
  name                = "io-sign-fn"
  namespace_name      = "io-p-sign-eventhub-ns"
  resource_group_name = "io-p-sign-integration-rg"

  listen = true
  send   = true
  manage = false
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "integration_event_hub_secrets" {
  for_each = module.event_hub.key_ids

  name         = format("%s-integration-evthub-key", replace(each.key, ".", "-"))
  value        = module.event_hub.keys[each.key].primary_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "integration_event_hub_jaas_connection_string" {
  for_each = module.event_hub.key_ids

  name         = format("%s-integration-evthub-conn-string", replace(each.key, ".", "-"))
  value        = "org.apache.kafka.common.security.plain.PlainLoginModule required username=\"$ConnectionString\" password=\"${module.event_hub.keys[each.key].primary_connection_string}\";"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}
