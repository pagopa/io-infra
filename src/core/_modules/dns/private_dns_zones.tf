resource "azurerm_private_dns_zone" "internal_io_pagopa_it" {
  count               = (var.dns_zones.io == null || var.external_domain == null) ? 0 : 1
  name                = join(".", ["internal", var.dns_zones.io, var.external_domain])
  resource_group_name = var.resource_groups.internal

  tags = var.tags
}

# api-app.internal.io.pagopa.it
# api-app.internal.dev.io.pagopa.it
resource "azurerm_private_dns_a_record" "api_app_internal_io" {
  name                = "api-app"
  zone_name           = azurerm_private_dns_zone.internal_io_pagopa_it[0].name
  resource_group_name = var.resource_groups.internal
  ttl                 = var.dns_default_ttl_sec
  records             = [var.apim_v2_public_ip]

  tags = var.tags
}

resource "azurerm_private_dns_zone" "privatelink_redis_cache" {
  name                = "privatelink.redis.cache.windows.net"
  resource_group_name = var.resource_groups.common

  tags = var.tags
}

resource "azurerm_private_dns_zone" "privatelink_postgres_database_azure_com" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = var.resource_groups.common

  tags = var.tags
}

resource "azurerm_private_dns_zone" "privatelink_mysql_database_azure_com" {
  name                = "privatelink.mysql.database.azure.com"
  resource_group_name = var.resource_groups.common

  tags = var.tags
}

resource "azurerm_private_dns_zone" "privatelink_azurecr_io" {
  name                = "privatelink.azurecr.io"
  resource_group_name = var.resource_groups.common

  tags = var.tags
}

resource "azurerm_private_dns_zone" "privatelink_mongo_cosmos" {
  name                = "privatelink.mongo.cosmos.azure.com"
  resource_group_name = var.resource_groups.common

  tags = var.tags
}

resource "azurerm_private_dns_zone" "privatelink_servicebus" {
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = var.resource_groups.event

  tags = var.tags
}

resource "azurerm_private_dns_zone" "privatelink_documents" {
  name                = "privatelink.documents.azure.com"
  resource_group_name = var.resource_groups.common

  tags = var.tags
}

resource "azurerm_private_dns_zone" "privatelink_blob_core" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.resource_groups.common

  tags = var.tags
}

resource "azurerm_private_dns_zone" "privatelink_file_core" {
  name                = "privatelink.file.core.windows.net"
  resource_group_name = var.resource_groups.common

  tags = var.tags
}

resource "azurerm_private_dns_zone" "privatelink_queue_core" {
  name                = "privatelink.queue.core.windows.net"
  resource_group_name = var.resource_groups.common

  tags = var.tags
}

resource "azurerm_private_dns_zone" "privatelink_table_core" {
  name                = "privatelink.table.core.windows.net"
  resource_group_name = var.resource_groups.common

  tags = var.tags
}

resource "azurerm_private_dns_zone" "privatelink_azurewebsites" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = var.resource_groups.common
}

resource "azurerm_private_dns_zone" "privatelink_srch" {
  name                = "privatelink.search.windows.net"
  resource_group_name = var.resource_groups.common
}