resource "azurerm_resource_group" "event_rg" {
  name     = format("%s-evt-rg", local.project)
  location = var.location

  tags = var.tags
}

module "event_hub" {
  count                    = var.ehns_enabled ? 1 : 0
  source                   = "github.com/pagopa/terraform-azurerm-v3//eventhub?ref=v8.27.0"
  name                     = format("%s-evh-ns", local.project)
  location                 = var.location
  resource_group_name      = azurerm_resource_group.event_rg.name
  auto_inflate_enabled     = var.ehns_auto_inflate_enabled
  sku                      = var.ehns_sku_name
  capacity                 = var.ehns_capacity
  maximum_throughput_units = var.ehns_maximum_throughput_units
  zone_redundant           = var.ehns_zone_redundant

  private_endpoint_created             = true
  private_endpoint_resource_group_name = azurerm_resource_group.event_rg.name
  private_endpoint_subnet_id           = data.azurerm_subnet.private_endpoints_subnet.id

  virtual_network_ids            = [data.azurerm_virtual_network.vnet_common.id]
  private_dns_zone_record_A_name = null

  eventhubs                     = var.eventhubs
  public_network_access_enabled = false

  alerts_enabled = var.ehns_alerts_enabled
  metric_alerts  = var.ehns_metric_alerts
  action = [
    {
      action_group_id    = data.azurerm_monitor_action_group.error_action_group.id
      webhook_properties = null
    }
  ]

  private_dns_zones = {
    id                  = [data.azurerm_private_dns_zone.privatelink_servicebus_windows_net.id]
    name                = [data.azurerm_private_dns_zone.privatelink_servicebus_windows_net.name]
    resource_group_name = data.azurerm_private_dns_zone.privatelink_servicebus_windows_net.resource_group_name
  }

  tags = var.tags
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "event_hub_keys" {
  for_each = var.ehns_enabled ? module.event_hub[0].key_ids : {}

  name         = "${replace(each.key, ".", "-")}-${var.location_short}-${var.instance}-evh-key"
  value        = module.event_hub[0].keys[each.key].primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}
