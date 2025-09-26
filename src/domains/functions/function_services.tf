# Subnet to host app function
module "services_snet" {
  count                                     = var.function_services_count
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v8.52.0"
  name                                      = format("%s-services-snet-%d", local.project, count.index + 1)
  address_prefixes                          = [var.cidr_subnet_services[count.index]]
  resource_group_name                       = local.rg_common_name
  virtual_network_name                      = local.vnet_common_name
  private_endpoint_network_policies_enabled = false

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage",
  ]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

removed {
  from = module.db_subscription_cidrs_container

  lifecycle {
    destroy = false
  }
}
