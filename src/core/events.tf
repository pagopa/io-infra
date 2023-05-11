resource "azurerm_resource_group" "event_rg" {
  name     = format("%s-evt-rg", local.project)
  location = var.location

  tags = var.tags
}

module "eventhub_snet" {
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v4.1.15"
  name                                      = format("%s-eventhub-snet", local.project)
  address_prefixes                          = var.cidr_subnet_eventhub
  resource_group_name                       = azurerm_resource_group.rg_common.name
  virtual_network_name                      = module.vnet_common.name
  service_endpoints                         = ["Microsoft.EventHub"]
  private_endpoint_network_policies_enabled = false
}

module "event_hub" {
  source                   = "git::https://github.com/pagopa/terraform-azurerm-v3.git//eventhub?ref=v4.1.15"
  name                     = format("%s-evh-ns", local.project)
  location                 = var.location
  resource_group_name      = azurerm_resource_group.event_rg.name
  auto_inflate_enabled     = var.ehns_auto_inflate_enabled
  sku                      = var.ehns_sku_name
  capacity                 = var.ehns_capacity
  maximum_throughput_units = var.ehns_maximum_throughput_units
  zone_redundant           = var.ehns_zone_redundant

  virtual_network_ids = [module.vnet_common.id]
  subnet_id           = module.eventhub_snet.id
  private_dns_zones = {
    id   = [azurerm_private_dns_zone.privatelink_servicebus.id]
    name = [azurerm_private_dns_zone.privatelink_servicebus.name]
  }

  eventhubs = var.eventhubs

  public_network_access_enabled = true
  network_rulesets = [
    {
      default_action = "Deny",
      virtual_network_rule = [
        {
          subnet_id                                       = module.function_elt_snetout.id,
          ignore_missing_virtual_network_service_endpoint = false
        }
      ],
      ip_rule = var.ehns_ip_rules
    }
  ]

  alerts_enabled = var.ehns_alerts_enabled
  metric_alerts  = var.ehns_metric_alerts
  action = [
    {
      action_group_id    = azurerm_monitor_action_group.slack.id
      webhook_properties = null
    },
    {
      action_group_id    = azurerm_monitor_action_group.email.id
      webhook_properties = null
    }
  ]

  tags = var.tags
}

locals {
  event_hub = {
    connection = "${format("%s-evh-ns", local.project)}.servicebus.windows.net:9093"
  }
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "event_hub_keys" {
  for_each = module.event_hub.key_ids

  name         = format("evh-%s-%s", replace(each.key, ".", "-"), "key")
  value        = module.event_hub.keys[each.key].primary_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id // ?
}
