resource "azurerm_private_dns_zone" "internal_io_pagopa_it" {
  count               = (var.dns_zone_io == null || var.external_domain == null) ? 0 : 1
  name                = join(".", ["internal", var.dns_zone_io, var.external_domain])
  resource_group_name = azurerm_resource_group.rg_internal.name

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "internal_io_pagopa_it_private_vnet_common" {
  name                  = format("%s-private-vnet-common", local.project)
  resource_group_name   = azurerm_resource_group.rg_internal.name
  private_dns_zone_name = azurerm_private_dns_zone.internal_io_pagopa_it[0].name
  virtual_network_id    = data.azurerm_virtual_network.vnet_common.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "internal_io_pagopa_it_private_vnet_beta" {
  name                  = module.vnet_weu_beta.name
  resource_group_name   = azurerm_resource_group.rg_internal.name
  private_dns_zone_name = azurerm_private_dns_zone.internal_io_pagopa_it[0].name
  virtual_network_id    = module.vnet_weu_beta.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "internal_io_pagopa_it_private_vnet_prod01" {
  name                  = module.vnet_weu_prod01.name
  resource_group_name   = azurerm_resource_group.rg_internal.name
  private_dns_zone_name = azurerm_private_dns_zone.internal_io_pagopa_it[0].name
  virtual_network_id    = module.vnet_weu_prod01.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "internal_io_pagopa_it_private_vnet_prod02" {
  name                  = module.vnet_weu_prod02.name
  resource_group_name   = azurerm_resource_group.rg_internal.name
  private_dns_zone_name = azurerm_private_dns_zone.internal_io_pagopa_it[0].name
  virtual_network_id    = module.vnet_weu_prod02.id
  registration_enabled  = false

  tags = var.tags
}

# api-app.internal.io.pagopa.it
# api-app.internal.dev.io.pagopa.it
resource "azurerm_private_dns_a_record" "api_app_internal_io" {
  name                = "api-app"
  zone_name           = azurerm_private_dns_zone.internal_io_pagopa_it[0].name
  resource_group_name = azurerm_resource_group.rg_internal.name
  ttl                 = var.dns_default_ttl_sec
  records             = module.apim.*.private_ip_addresses[0]

  tags = var.tags
}

resource "azurerm_private_dns_zone" "privatelink_redis_cache" {
  name                = "privatelink.redis.cache.windows.net"
  resource_group_name = data.azurerm_resource_group.vnet_common_rg.name

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "redis_private_vnet_common" {
  name                  = format("%s-redis-common-common", local.project)
  resource_group_name   = data.azurerm_resource_group.vnet_common_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_redis_cache.name
  virtual_network_id    = data.azurerm_virtual_network.vnet_common.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "redis_private_vnet_beta" {
  name                  = module.vnet_weu_beta.name
  resource_group_name   = data.azurerm_resource_group.vnet_common_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_redis_cache.name
  virtual_network_id    = module.vnet_weu_beta.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "redis_private_vnet_prod01" {
  name                  = module.vnet_weu_prod01.name
  resource_group_name   = data.azurerm_resource_group.vnet_common_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_redis_cache.name
  virtual_network_id    = module.vnet_weu_prod01.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "redis_private_vnet_prod02" {
  name                  = module.vnet_weu_prod02.name
  resource_group_name   = data.azurerm_resource_group.vnet_common_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_redis_cache.name
  virtual_network_id    = module.vnet_weu_prod02.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone" "privatelink_postgres_database_azure_com" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = data.azurerm_resource_group.vnet_common_rg.name

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_postgres_database_azure_com_vnet_common" {
  name                  = data.azurerm_virtual_network.vnet_common.name
  resource_group_name   = data.azurerm_resource_group.vnet_common_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_postgres_database_azure_com.name
  virtual_network_id    = data.azurerm_virtual_network.vnet_common.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_postgres_database_azure_com_vnet_beta" {
  name                  = module.vnet_weu_beta.name
  resource_group_name   = data.azurerm_resource_group.vnet_common_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_postgres_database_azure_com.name
  virtual_network_id    = module.vnet_weu_beta.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_postgres_database_azure_com_vnet_prod01" {
  name                  = module.vnet_weu_prod01.name
  resource_group_name   = data.azurerm_resource_group.vnet_common_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_postgres_database_azure_com.name
  virtual_network_id    = module.vnet_weu_prod01.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_postgres_database_azure_com_vnet_prod02" {
  name                  = module.vnet_weu_prod02.name
  resource_group_name   = data.azurerm_resource_group.vnet_common_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_postgres_database_azure_com.name
  virtual_network_id    = module.vnet_weu_prod02.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone" "privatelink_mysql_database_azure_com" {
  name                = "privatelink.mysql.database.azure.com"
  resource_group_name = data.azurerm_resource_group.vnet_common_rg.name

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_mysql_database_azure_com_vnet_common" {
  name                  = data.azurerm_virtual_network.vnet_common.name
  resource_group_name   = data.azurerm_resource_group.vnet_common_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_mysql_database_azure_com.name
  virtual_network_id    = data.azurerm_virtual_network.vnet_common.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_mysql_database_azure_com_vnet_beta" {
  name                  = module.vnet_weu_beta.name
  resource_group_name   = data.azurerm_resource_group.vnet_common_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_mysql_database_azure_com.name
  virtual_network_id    = module.vnet_weu_beta.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_mysql_database_azure_com_vnet_prod01" {
  name                  = module.vnet_weu_prod01.name
  resource_group_name   = data.azurerm_resource_group.vnet_common_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_mysql_database_azure_com.name
  virtual_network_id    = module.vnet_weu_prod01.id
  registration_enabled  = false

  tags = var.tags
}


resource "azurerm_private_dns_zone" "privatelink_azurecr_io" {
  name                = "privatelink.azurecr.io"
  resource_group_name = data.azurerm_resource_group.vnet_common_rg.name

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_azurecr_io_vnet_common" {
  name                  = data.azurerm_virtual_network.vnet_common.name
  resource_group_name   = data.azurerm_resource_group.vnet_common_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_azurecr_io.name
  virtual_network_id    = data.azurerm_virtual_network.vnet_common.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_azurecr_io_vnet_beta" {
  name                  = module.vnet_weu_beta.name
  resource_group_name   = data.azurerm_resource_group.vnet_common_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_azurecr_io.name
  virtual_network_id    = module.vnet_weu_beta.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_azurecr_io_vnet_prod01" {
  name                  = module.vnet_weu_prod01.name
  resource_group_name   = data.azurerm_resource_group.vnet_common_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_azurecr_io.name
  virtual_network_id    = module.vnet_weu_prod01.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_azurecr_io_vnet_prod02" {
  name                  = module.vnet_weu_prod02.name
  resource_group_name   = data.azurerm_resource_group.vnet_common_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_azurecr_io.name
  virtual_network_id    = module.vnet_weu_prod02.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone" "privatelink_mongo_cosmos" {
  name                = "privatelink.mongo.cosmos.azure.com"
  resource_group_name = data.azurerm_resource_group.vnet_common_rg.name

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "mongo_cosmos_private_vnet_common" {
  name                  = data.azurerm_virtual_network.vnet_common.name
  resource_group_name   = data.azurerm_resource_group.vnet_common_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_mongo_cosmos.name
  virtual_network_id    = data.azurerm_virtual_network.vnet_common.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "mongo_cosmos_private_vnet_beta" {
  name                  = module.vnet_weu_beta.name
  resource_group_name   = data.azurerm_resource_group.vnet_common_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_mongo_cosmos.name
  virtual_network_id    = module.vnet_weu_beta.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "mongo_cosmos_private_vnet_prod01" {
  name                  = module.vnet_weu_prod01.name
  resource_group_name   = data.azurerm_resource_group.vnet_common_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_mongo_cosmos.name
  virtual_network_id    = module.vnet_weu_prod01.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "mongo_cosmos_private_vnet_prod02" {
  name                  = module.vnet_weu_prod02.name
  resource_group_name   = data.azurerm_resource_group.vnet_common_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_mongo_cosmos.name
  virtual_network_id    = module.vnet_weu_prod02.id
  registration_enabled  = false

  tags = var.tags
}

data "azurerm_private_dns_zone" "privatelink_servicebus" {
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = format("%s-evt-rg", local.project)
}

resource "azurerm_private_dns_zone_virtual_network_link" "servicebus_private_vnet_beta" {
  name                  = module.vnet_weu_beta.name
  resource_group_name   = format("%s-evt-rg", local.project)
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_servicebus.name
  virtual_network_id    = module.vnet_weu_beta.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "servicebus_private_vnet_prod01" {
  name                  = module.vnet_weu_prod01.name
  resource_group_name   = format("%s-evt-rg", local.project)
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_servicebus.name
  virtual_network_id    = module.vnet_weu_prod01.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "servicebus_private_vnet_prod02" {
  name                  = module.vnet_weu_prod02.name
  resource_group_name   = format("%s-evt-rg", local.project)
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_servicebus.name
  virtual_network_id    = module.vnet_weu_prod02.id
  registration_enabled  = false

  tags = var.tags
}

data "azurerm_private_dns_zone" "privatelink_documents" {
  name                = "privatelink.documents.azure.com"
  resource_group_name = format("%s-rg-common", local.project)
}

resource "azurerm_private_dns_zone_virtual_network_link" "documents_private_vnet_beta" {
  name                  = module.vnet_weu_beta.name
  resource_group_name   = format("%s-rg-common", local.project)
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_documents.name
  virtual_network_id    = module.vnet_weu_beta.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "documents_private_vnet_prod01" {
  name                  = module.vnet_weu_prod01.name
  resource_group_name   = format("%s-rg-common", local.project)
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_documents.name
  virtual_network_id    = module.vnet_weu_prod01.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "documents_private_vnet_prod02" {
  name                  = module.vnet_weu_prod02.name
  resource_group_name   = format("%s-rg-common", local.project)
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_documents.name
  virtual_network_id    = module.vnet_weu_prod02.id
  registration_enabled  = false

  tags = var.tags
}

data "azurerm_private_dns_zone" "privatelink_blob_core" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = format("%s-rg-common", local.project)
}

resource "azurerm_private_dns_zone_virtual_network_link" "blob_core_private_vnet_beta" {
  name                  = module.vnet_weu_beta.name
  resource_group_name   = format("%s-rg-common", local.project)
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_blob_core.name
  virtual_network_id    = module.vnet_weu_beta.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "blob_core_private_vnet_prod01" {
  name                  = module.vnet_weu_prod01.name
  resource_group_name   = format("%s-rg-common", local.project)
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_blob_core.name
  virtual_network_id    = module.vnet_weu_prod01.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "blob_core_private_vnet_prod02" {
  name                  = module.vnet_weu_prod02.name
  resource_group_name   = format("%s-rg-common", local.project)
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_blob_core.name
  virtual_network_id    = module.vnet_weu_prod02.id
  registration_enabled  = false

  tags = var.tags
}

data "azurerm_private_dns_zone" "privatelink_file_core" {
  name                = "privatelink.file.core.windows.net"
  resource_group_name = format("%s-rg-common", local.project)
}

resource "azurerm_private_dns_zone_virtual_network_link" "file_core_private_vnet_beta" {
  name                  = module.vnet_weu_beta.name
  resource_group_name   = format("%s-rg-common", local.project)
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_file_core.name
  virtual_network_id    = module.vnet_weu_beta.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "file_core_private_vnet_prod01" {
  name                  = module.vnet_weu_prod01.name
  resource_group_name   = format("%s-rg-common", local.project)
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_file_core.name
  virtual_network_id    = module.vnet_weu_prod01.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "file_core_private_vnet_prod02" {
  name                  = module.vnet_weu_prod02.name
  resource_group_name   = format("%s-rg-common", local.project)
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_file_core.name
  virtual_network_id    = module.vnet_weu_prod02.id
  registration_enabled  = false

  tags = var.tags
}

data "azurerm_private_dns_zone" "privatelink_queue_core" {
  name                = "privatelink.queue.core.windows.net"
  resource_group_name = format("%s-rg-common", local.project)
}

resource "azurerm_private_dns_zone_virtual_network_link" "queue_core_private_vnet_beta" {
  name                  = module.vnet_weu_beta.name
  resource_group_name   = format("%s-rg-common", local.project)
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_queue_core.name
  virtual_network_id    = module.vnet_weu_beta.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "queue_core_private_vnet_prod01" {
  name                  = module.vnet_weu_prod01.name
  resource_group_name   = format("%s-rg-common", local.project)
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_queue_core.name
  virtual_network_id    = module.vnet_weu_prod01.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "queue_core_private_vnet_prod02" {
  name                  = module.vnet_weu_prod02.name
  resource_group_name   = format("%s-rg-common", local.project)
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_queue_core.name
  virtual_network_id    = module.vnet_weu_prod02.id
  registration_enabled  = false

  tags = var.tags
}

data "azurerm_private_dns_zone" "privatelink_table_core" {
  name                = "privatelink.table.core.windows.net"
  resource_group_name = format("%s-rg-common", local.project)
}

resource "azurerm_private_dns_zone_virtual_network_link" "table_core_private_vnet_beta" {
  name                  = module.vnet_weu_beta.name
  resource_group_name   = format("%s-rg-common", local.project)
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_table_core.name
  virtual_network_id    = module.vnet_weu_beta.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "table_core_private_vnet_prod01" {
  name                  = module.vnet_weu_prod01.name
  resource_group_name   = format("%s-rg-common", local.project)
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_table_core.name
  virtual_network_id    = module.vnet_weu_prod01.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "table_core_private_vnet_prod02" {
  name                  = module.vnet_weu_prod02.name
  resource_group_name   = format("%s-rg-common", local.project)
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_table_core.name
  virtual_network_id    = module.vnet_weu_prod02.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone" "privatelink_azurewebsites" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = format("%s-rg-common", local.project)
}

resource "azurerm_private_dns_zone_virtual_network_link" "azurewebsites_private_vnet_common" {
  name                  = data.azurerm_virtual_network.vnet_common.name
  resource_group_name   = data.azurerm_resource_group.vnet_common_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_azurewebsites.name
  virtual_network_id    = data.azurerm_virtual_network.vnet_common.id
  registration_enabled  = false

  tags = var.tags
}
