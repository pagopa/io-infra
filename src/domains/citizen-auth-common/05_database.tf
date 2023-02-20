resource "azurerm_resource_group" "data_rg" {
  name     = "${local.product}-${var.domain}-data-rg"
  location = var.location

  tags = var.tags
}

module "cosmosdb_account" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//cosmosdb_account?ref=v4.3.1"

  name                = "${local.product}-${var.domain}-account"
  domain              = upper(var.domain)
  location            = azurerm_resource_group.data_rg.location
  resource_group_name = azurerm_resource_group.data_rg.name
  offer_type          = "Standard"
  enable_free_tier    = false
  kind                = "GlobalDocumentDB"

  public_network_access_enabled     = false
  private_endpoint_enabled          = true
  subnet_id                         = data.azurerm_subnet.private_endpoints_subnet.id
  private_dns_zone_ids              = [data.azurerm_private_dns_zone.privatelink_documents_azure_com.id]
  is_virtual_network_filter_enabled = false

  main_geo_location_location       = azurerm_resource_group.data_rg.location
  main_geo_location_zone_redundant = false
  additional_geo_locations = [{
    location          = "northeurope"
    failover_priority = 1
    zone_redundant    = false
  }]
  consistency_policy = {
    consistency_level       = "Session"
    max_interval_in_seconds = null
    max_staleness_prefix    = null
  }

  tags = var.tags
}

module "cosmosdb_sql_database_citizen_auth" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3//cosmosdb_sql_database?ref=v4.3.1"
  name                = "citizen-auth"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account.name
}
#
# LolliPOP containers
#
resource "azurerm_cosmosdb_sql_container" "lollipop_pubkeys" {

  name                = "lollipop-pubkeys"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account.name
  database_name       = module.cosmosdb_sql_database_citizen_auth.name

  partition_key_path    = "/assertionRef"
  partition_key_version = 2

  dynamic "autoscale_settings" {
    for_each = [""]
    content {
      max_throughput = 1000
    }
  }

  lifecycle {
    ignore_changes = [
      autoscale_settings
    ]
  }

  default_ttl = -1

}