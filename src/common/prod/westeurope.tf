data "azurerm_resource_group" "common_weu" {
  name = format("%s-rg-common", local.project_weu_legacy)
}

module "event_hubs_weu" {
  source = "../_modules/event_hubs"

  location       = data.azurerm_resource_group.common_weu.location
  location_short = local.location_short[data.azurerm_resource_group.common_weu.location]
  project        = local.project_weu_legacy

  resource_group_common = data.azurerm_resource_group.common_weu.name
  servicebus_dns_zone   = local.core.global.dns.private_dns_zones.servicebus
  vnet_common           = local.core.networking.weu.vnet_common
  key_vault             = local.core.key_vault.weu.kv
  error_action_group_id = data.azurerm_monitor_action_group.error_action_group.id

  cidr_subnet = ["10.0.10.0/24"]
  sku_name    = "Standard"
  eventhubs   = local.eventhubs
  ip_rules = [
    {
      ip_mask = "18.192.147.151", # PDND
      action  = "Allow"
    },
    {
      ip_mask = "18.159.227.69", # PDND
      action  = "Allow"
    },
    {
      ip_mask = "3.126.198.129", # PDND
      action  = "Allow"
    }
  ]

  tags = local.tags
}
