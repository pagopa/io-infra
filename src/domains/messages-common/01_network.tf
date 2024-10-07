data "azurerm_virtual_network" "vnet_common" {
  name                = local.vnet_common_name
  resource_group_name = local.vnet_common_resource_group_name
}

data "azurerm_private_dns_zone" "privatelink_redis_cache" {
  name                = "privatelink.redis.cache.windows.net"
  resource_group_name = local.vnet_common_resource_group_name
}

data "azurerm_private_dns_zone" "privatelink_mongo_cosmos_azure_com" {
  name                = "privatelink.mongo.cosmos.azure.com"
  resource_group_name = format("%s-rg-common", local.product)
}

data "azurerm_private_dns_zone" "privatelink_postgres_azure_com" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = format("%s-rg-common", local.product)
}

data "azurerm_private_dns_zone" "privatelink_mysql_azure_com" {
  name                = "privatelink.mysql.database.azure.com"
  resource_group_name = format("%s-rg-common", local.product)
}

data "azurerm_private_dns_zone" "privatelink_documents_azure_com" {
  name                = "privatelink.documents.azure.com"
  resource_group_name = "io-p-rg-common"
}

data "azurerm_subnet" "private_endpoints_subnet" {
  name                 = "pendpoints"
  virtual_network_name = local.vnet_common_name
  resource_group_name  = local.vnet_common_resource_group_name
}

data "azurerm_subnet" "pep_subnet_itn" {
  name                 = "${local.project_itn}-pep-snet-01"
  virtual_network_name = local.vnet_common_name_itn
  resource_group_name  = local.vnet_common_resource_group_name_itn
}

data "azurerm_subnet" "azdoa_snet" {
  count                = var.enable_azdoa ? 1 : 0
  name                 = "azure-devops"
  virtual_network_name = local.vnet_common_name
  resource_group_name  = local.vnet_common_resource_group_name
}

resource "azurerm_private_endpoint" "cosno_reminder_itn" {
  name                = "${local.project_itn}-msgs-reminder-cosno-pep-01"
  location            = "italynorth"
  resource_group_name = azurerm_resource_group.data_rg.name
  subnet_id           = data.azurerm_subnet.pep_subnet_itn.id

  private_service_connection {
    name                           = "${local.project_itn}-msgs-reminder-cosno-pep-01"
    private_connection_resource_id = module.cosmosdb_account_mongodb_reminder.id
    is_manual_connection           = false
    subresource_names              = ["Sql"]
  }
}

resource "azurerm_private_endpoint" "cosno_remote_content_itn" {
  name                = "${local.project_itn}-msgs-remote-content-cosno-pep-01"
  location            = "italynorth"
  resource_group_name = azurerm_resource_group.data_rg.name
  subnet_id           = data.azurerm_subnet.pep_subnet_itn.id

  private_service_connection {
    name                           = "${local.project_itn}-msgs-remote-content-cosno-pep-01"
    private_connection_resource_id = module.cosmosdb_account_mongodb_reminder.id
    is_manual_connection           = false
    subresource_names              = ["Sql"]
  }
}
