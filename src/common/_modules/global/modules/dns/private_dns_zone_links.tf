resource "azurerm_private_dns_zone_virtual_network_link" "internal_io_pagopa_it_private_vnet" {
  for_each              = var.vnets
  name                  = each.key == "weu" ? "${var.project}-private-vnet-common" : each.value.name
  resource_group_name   = var.resource_groups.internal
  private_dns_zone_name = azurerm_private_dns_zone.internal_io_pagopa_it.name
  virtual_network_id    = each.value.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "redis_private_vnet" {
  for_each              = var.vnets
  name                  = each.key == "weu" ? "${var.project}-redis-common-common" : each.value.name
  resource_group_name   = var.resource_groups.common
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_redis_cache.name
  virtual_network_id    = each.value.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_postgres_database_azure_com_vnet" {
  for_each              = var.vnets
  name                  = each.value.name
  resource_group_name   = var.resource_groups.common
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_postgres_database_azure_com.name
  virtual_network_id    = each.value.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_mysql_database_azure_com_vnet" {
  for_each              = var.vnets
  name                  = each.value.name
  resource_group_name   = var.resource_groups.common
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_mysql_database_azure_com.name
  virtual_network_id    = each.value.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_azurecr_io_vnet" {
  for_each              = var.vnets
  name                  = each.value.name
  resource_group_name   = var.resource_groups.common
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_azurecr_io.name
  virtual_network_id    = each.value.id
  registration_enabled  = false

  tags = var.tags
}


resource "azurerm_private_dns_zone_virtual_network_link" "mongo_cosmos_private_vnet" {
  for_each              = var.vnets
  name                  = each.value.name
  resource_group_name   = var.resource_groups.common
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_mongo_cosmos.name
  virtual_network_id    = each.value.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "servicebus_private_vnet" {
  for_each              = var.vnets
  name                  = each.key == "weu" ? "io-p-evh-ns-private-dns-zone-link-01" : each.value.name
  resource_group_name   = var.resource_groups.event
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_servicebus.name
  virtual_network_id    = each.value.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "documents_private_vnet" {
  for_each              = var.vnets
  name                  = each.value.name
  resource_group_name   = var.resource_groups.common
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_documents.name
  virtual_network_id    = each.value.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "blob_core_private_vnet" {
  for_each              = var.vnets
  name                  = each.value.name
  resource_group_name   = var.resource_groups.common
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_blob_core.name
  virtual_network_id    = each.value.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "file_core_private_vnet" {
  for_each              = var.vnets
  name                  = each.value.name
  resource_group_name   = var.resource_groups.common
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_file_core.name
  virtual_network_id    = each.value.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "queue_core_private_vnet" {
  for_each              = var.vnets
  name                  = each.value.name
  resource_group_name   = var.resource_groups.common
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_queue_core.name
  virtual_network_id    = each.value.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "table_core_private_vnet" {
  for_each              = var.vnets
  name                  = each.value.name
  resource_group_name   = var.resource_groups.common
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_table_core.name
  virtual_network_id    = each.value.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "azurewebsites_private_vnet" {
  for_each              = var.vnets
  name                  = each.value.name
  resource_group_name   = var.resource_groups.common
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_azurewebsites.name
  virtual_network_id    = each.value.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "srch_private_vnet_common" {
  for_each              = { for name, vnet in var.vnets : name => vnet if contains(["weu", "itn"], name) }
  name                  = each.value.name
  resource_group_name   = var.resource_groups.common
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_srch.name
  virtual_network_id    = each.value.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "vault_private_vnet_common" {
  for_each              = { for name, vnet in var.vnets : name => vnet if contains(["weu", "itn"], name) }
  name                  = each.value.name
  resource_group_name   = var.resource_groups.common
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_vault.name
  virtual_network_id    = each.value.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "azure_api_net_vnet_common" {
  for_each              = { for name, vnet in var.vnets : name => vnet if contains(["weu", "itn"], name) }
  name                  = each.value.name
  resource_group_name   = var.resource_groups.common
  private_dns_zone_name = azurerm_private_dns_zone.azure_api_net.name
  virtual_network_id    = each.value.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "management_azure_api_net_vnet_common" {
  for_each              = { for name, vnet in var.vnets : name => vnet if contains(["weu", "itn"], name) }
  name                  = each.value.name
  resource_group_name   = var.resource_groups.common
  private_dns_zone_name = azurerm_private_dns_zone.management_azure_api_net.name
  virtual_network_id    = each.value.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "scm_azure_api_net_vnet_common" {
  for_each              = { for name, vnet in var.vnets : name => vnet if contains(["weu", "itn"], name) }
  name                  = each.value.name
  resource_group_name   = var.resource_groups.common
  private_dns_zone_name = azurerm_private_dns_zone.scm_azure_api_net.name
  virtual_network_id    = each.value.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_itn_containerapps_vnet_common" {
  for_each              = { for name, vnet in var.vnets : name => vnet if contains(["weu", "itn"], name) }
  name                  = each.value.name
  resource_group_name   = var.resource_groups.common
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_itn_containerapps.name
  virtual_network_id    = each.value.id
  registration_enabled  = false

  tags = var.tags
}
