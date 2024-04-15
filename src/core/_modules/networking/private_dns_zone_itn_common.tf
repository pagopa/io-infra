resource "azurerm_private_dns_zone_virtual_network_link" "internal_io_pagopa_it_private_vnet_itn_common" {
  name = module.vnet_itn_common.name

  virtual_network_id    = module.vnet_itn_common.id
  resource_group_name   = data.azurerm_private_dns_zone.internal_io_pagopa_it.resource_group_name
  private_dns_zone_name = data.azurerm_private_dns_zone.internal_io_pagopa_it.name

  registration_enabled = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_postgres_database_azure_com_vnet_itn_common" {
  name = module.vnet_itn_common.name

  virtual_network_id    = module.vnet_itn_common.id
  resource_group_name   = data.azurerm_private_dns_zone.privatelink_postgres_database_azure_com.resource_group_name
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_postgres_database_azure_com.name

  registration_enabled = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "mongo_cosmos_private_vnet_itn_common" {
  name = module.vnet_itn_common.name

  virtual_network_id    = module.vnet_itn_common.id
  resource_group_name   = data.azurerm_private_dns_zone.privatelink_mongo_cosmos.resource_group_name
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_mongo_cosmos.name

  registration_enabled = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "servicebus_private_vnet_itn_common" {
  name = module.vnet_itn_common.name

  virtual_network_id    = module.vnet_itn_common.id
  resource_group_name   = data.azurerm_private_dns_zone.privatelink_servicebus.resource_group_name
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_servicebus.name

  registration_enabled = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "documents_private_vnet_itn_common" {
  name = module.vnet_itn_common.name

  virtual_network_id    = module.vnet_itn_common.id
  resource_group_name   = data.azurerm_private_dns_zone.privatelink_documents.resource_group_name
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_documents.name

  registration_enabled = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "blob_core_private_vnet_itn_common" {
  name = module.vnet_itn_common.name

  virtual_network_id    = module.vnet_itn_common.id
  resource_group_name   = data.azurerm_private_dns_zone.privatelink_blob_core.resource_group_name
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_blob_core.name
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "file_core_private_vnet_itn_common" {
  name = module.vnet_itn_common.name

  virtual_network_id    = module.vnet_itn_common.id
  resource_group_name   = data.azurerm_private_dns_zone.privatelink_file_core.resource_group_name
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_file_core.name

  registration_enabled = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "queue_core_private_vnet_itn_common" {
  name = module.vnet_itn_common.name

  virtual_network_id    = module.vnet_itn_common.id
  resource_group_name   = data.azurerm_private_dns_zone.privatelink_queue_core.resource_group_name
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_queue_core.name

  registration_enabled = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "table_core_private_vnet_itn_common" {
  name = module.vnet_itn_common.name

  virtual_network_id    = module.vnet_itn_common.id
  resource_group_name   = data.azurerm_private_dns_zone.privatelink_table_core.resource_group_name
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_table_core.name

  registration_enabled = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "azurewebsites_private_vnet_itn_common" {
  name = module.vnet_itn_common.name

  virtual_network_id    = module.vnet_itn_common.id
  resource_group_name   = data.azurerm_private_dns_zone.privatelink_azurewebsites.resource_group_name
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_azurewebsites.name

  registration_enabled = false

  tags = var.tags
}
