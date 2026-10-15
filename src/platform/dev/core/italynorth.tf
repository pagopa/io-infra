resource "azurerm_resource_group" "platform" {
  name     = "${local.project}-platform-rg-01"
  location = local.location

  tags = local.tags
}

resource "azurerm_resource_group" "test_services" {
  name     = "${local.project}-test-services-rg-01"
  location = local.location

  tags = local.tags
}

module "cosmosdb_test_services" {
  source = "./_modules/cosmosdb"

  prefix   = local.prefix
  location = local.location

  resource_group_name                  = azurerm_resource_group.test_services.name
  private_dns_zone_resource_group_name = data.azurerm_resource_group.itn_common.name
  tags                                 = local.tags
}