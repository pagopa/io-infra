data "azurerm_virtual_network" "vnet_common" {
  name                = local.vnet_common_name
  resource_group_name = local.vnet_common_resource_group_name
}

data "azurerm_subnet" "private_endpoints_subnet" {
  name                 = "pendpoints"
  virtual_network_name = local.vnet_common_name
  resource_group_name  = local.vnet_common_resource_group_name
}

data "azurerm_subnet" "azdoa_snet" {
  count                = var.enable_azdoa ? 1 : 0
  name                 = "azure-devops"
  virtual_network_name = local.vnet_common_name
  resource_group_name  = local.vnet_common_resource_group_name
}

data "azurerm_private_dns_zone" "privatelink_blob_core_windows_net" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = local.vnet_common_resource_group_name
}

data "azurerm_private_dns_zone" "privatelink_queue_core_windows_net" {
  name                = "privatelink.queue.core.windows.net"
  resource_group_name = local.vnet_common_resource_group_name
}

data "azurerm_private_dns_zone" "privatelink_documents_azure_com" {
  name                = "privatelink.documents.azure.com"
  resource_group_name = "io-p-rg-common"
}

data "azurerm_private_dns_zone" "privatelink_mongo_cosmos_azure_com" {
  name                = "privatelink.mongo.cosmos.azure.com"
  resource_group_name = "io-p-rg-common"
}

data "azurerm_private_dns_zone" "privatelink_redis_cache" {
  name                = "privatelink.redis.cache.windows.net"
  resource_group_name = local.vnet_common_resource_group_name
}

data "azurerm_private_dns_zone" "privatelink_table_core" {
  name                = "privatelink.table.core.windows.net"
  resource_group_name = local.vnet_common_resource_group_name
}

data "azurerm_subnet" "private_endpoints_subnet_itn" {
  name                 = "io-p-itn-pep-snet-01"
  virtual_network_name = "io-p-itn-common-vnet-01"
  resource_group_name  = "io-p-itn-common-rg-01"
}

## Redis Common subnet
module "redis_common_snet" {
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v8.44.0"
  name                 = format("%s-redis-snet", local.project)
  address_prefixes     = var.cidr_subnet_redis_common
  resource_group_name  = local.vnet_common_resource_group_name
  virtual_network_name = local.vnet_common_name

  private_endpoint_network_policies_enabled = false
}

## Cosmos Private Endpoint
resource "azurerm_private_endpoint" "cosmos_db" {
  name                = "${local.product}-citizen-auth-account"
  location            = "italynorth"
  resource_group_name = azurerm_resource_group.data_rg.name
  subnet_id           = data.azurerm_subnet.private_endpoints_subnet_itn.id

  private_service_connection {
    name                           = "${local.product}-citizen-auth-account-private-endpoint"
    private_connection_resource_id = module.cosmosdb_account.id
    is_manual_connection           = false
    subresource_names              = ["Sql"]
  }
}