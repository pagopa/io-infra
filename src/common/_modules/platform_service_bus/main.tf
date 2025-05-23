module "platform_service_bus_namespace" {
  source  = "pagopa-dx/azure-service-bus-namespace/azurerm"
  version = "~> 0.0"

  environment = {
    prefix          = var.prefix
    env_short       = "p"
    location        = var.location
    app_name        = "platform"
    instance_number = "01"
  }

  resource_group_name = var.resource_group_internal

  subnet_pep_id                        = var.pep_snet_id
  private_dns_zone_resource_group_name = var.resource_group_event

  // Premium SKU
  tier = "l"

  tags = var.tags
}
