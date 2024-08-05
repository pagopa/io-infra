resource "azurerm_resource_group" "event_rg" {
  name     = format("%s-evt-rg", var.project)
  location = var.location

  tags = var.tags
}

module "eventhub_snet" {
  source                                    = "github.com/pagopa/terraform-azurerm-v3//subnet?ref=v8.35.0"
  name                                      = format("%s-eventhub-snet", var.project)
  address_prefixes                          = var.ehns_cidr_subnet
  resource_group_name                       = var.resource_group_common
  virtual_network_name                      = var.vnet_common.name
  service_endpoints                         = ["Microsoft.EventHub"]
  private_endpoint_network_policies_enabled = false
}

module "event_hub" {
  source                   = "github.com/pagopa/terraform-azurerm-v3//eventhub?ref=v8.35.0"
  name                     = format("%s-evh-ns", var.project)
  location                 = var.location
  resource_group_name      = azurerm_resource_group.event_rg.name
  auto_inflate_enabled     = var.ehns_auto_inflate_enabled
  sku                      = var.ehns_sku_name
  capacity                 = var.ehns_capacity
  maximum_throughput_units = var.ehns_maximum_throughput_units
  zone_redundant           = var.ehns_zone_redundant
  private_endpoint_created = false

  virtual_network_ids = [var.vnet_common.id]
  # subnet_id           = module.eventhub_snet.id
  private_dns_zones = {
    id                  = [var.privatelink_servicebus_dns_zone.id]
    name                = [var.privatelink_servicebus_dns_zone.name]
    resource_group_name = var.privatelink_servicebus_dns_zone.resource_group_name
  }

  eventhubs = var.eventhubs

  public_network_access_enabled = true
  network_rulesets = [
    {
      default_action = "Deny",
      virtual_network_rule = [
        {
          subnet_id                                       = data.azurerm_subnet.function_let_snet.id
          ignore_missing_virtual_network_service_endpoint = false
        }
      ],
      ip_rule                        = var.ehns_ip_rules
      trusted_service_access_enabled = false
    }
  ]

  alerts_enabled = var.ehns_alerts_enabled
  metric_alerts  = local.ehns_metric_alerts
  action = [
    {
      action_group_id    = data.azurerm_monitor_action_group.error_action_group.id
      webhook_properties = null
    }
  ]

  tags = var.tags
}

locals {
  event_hub = {
    connection = "${format("%s-evh-ns", var.project)}.servicebus.windows.net:9093"
  }
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "event_hub_keys" {
  for_each = module.event_hub.key_ids

  name         = format("evh-%s-%s", replace(each.key, ".", "-"), "key")
  value        = module.event_hub.keys[each.key].primary_key
  content_type = "text/plain"

  key_vault_id = var.key_vault.id // ?
}
