data "azurerm_virtual_network" "weu_common" {
  name                = "io-p-vnet-common"
  resource_group_name = "io-p-rg-common"
}

data "azurerm_virtual_network" "weu_beta" {
  name                = "io-p-weu-beta-vnet"
  resource_group_name = "io-p-weu-beta-vnet-rg"
}

data "azurerm_virtual_network" "weu_prod01" {
  name                = "io-p-weu-prod01-vnet"
  resource_group_name = "io-p-weu-prod01-vnet-rg"
}

data "azurerm_private_dns_zone" "internal_io_pagopa_it" {
  name                = "internal.io.pagopa.it"
  resource_group_name = "io-p-rg-internal"
}

data "azurerm_private_dns_zone" "privatelink_postgres_database_azure_com" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = "io-p-rg-common"
}

data "azurerm_private_dns_zone" "privatelink_mongo_cosmos" {
  name                = "privatelink.mongo.cosmos.azure.com"
  resource_group_name = "io-p-rg-common"
}

data "azurerm_private_dns_zone" "privatelink_servicebus" {
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = "io-p-evt-rg"
}

data "azurerm_private_dns_zone" "privatelink_documents" {
  name                = "privatelink.documents.azure.com"
  resource_group_name = "io-p-rg-common"
}

data "azurerm_private_dns_zone" "privatelink_blob_core" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = "io-p-rg-common"
}

data "azurerm_private_dns_zone" "privatelink_file_core" {
  name                = "privatelink.file.core.windows.net"
  resource_group_name = "io-p-rg-common"
}

data "azurerm_private_dns_zone" "privatelink_queue_core" {
  name                = "privatelink.queue.core.windows.net"
  resource_group_name = "io-p-rg-common"
}

data "azurerm_private_dns_zone" "privatelink_table_core" {
  name                = "privatelink.table.core.windows.net"
  resource_group_name = "io-p-rg-common"
}

data "azurerm_private_dns_zone" "privatelink_azurewebsites" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = "io-p-rg-common"
}
