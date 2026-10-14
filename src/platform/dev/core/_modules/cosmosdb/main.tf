module "account" {
  source  = "pagopa-dx/azure-cosmos-account/azurerm"
  version = "~> 2.0"

  environment = {
    prefix          = var.prefix
    env_short       = "d"
    location        = var.location
    app_name        = "test-services"
    instance_number = "01"
  }
  resource_group_name = var.resource_group_name
  use_case            = "development"

  force_public_network_access_enabled  = true
  private_dns_zone_resource_group_name = var.private_dns_zone_resource_group_name

  primary_geo_location = {
    location       = var.location
    zone_redundant = false
  }
  secondary_geo_locations = []

  consistency_policy = {
    consistency_preset = "Default"
  }

  alerts = {
    enabled = false
  }

  diagnostic_settings = {
    enabled = false
  }

  tags = var.tags
}

moved {
  from = azurerm_cosmosdb_account.this
  to   = module.account.azurerm_cosmosdb_account.this
}