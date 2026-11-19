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

module "apim_test_caller" {
  source = "./_modules/function_apim_test"

  prefix              = local.prefix
  env_short           = local.env_short
  location            = local.location
  resource_group_name = azurerm_resource_group.test_services.name

  virtual_network              = data.azurerm_virtual_network.itn_common
  private_endpoint_subnet_name = "${local.project}-common-pep-snet-01"
  private_dns_zone_ids         = module.dns.zones.function_private_dns_zone_ids

  api_management = {
    name                = "${local.project}-apim-01"
    resource_group_name = "${local.project}-apim-rg-01"
  }
  api_application_display_name = "${local.prefix}-${local.env_short}-test-apim-entraid-01"

  tags = local.tags
}

output "function_apim_test_name" {
  description = "Name of the private Function App for the APIM smoke test."
  value       = module.apim_test_caller.name
}