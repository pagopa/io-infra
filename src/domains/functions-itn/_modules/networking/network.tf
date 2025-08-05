# Subnet to host app function
module "services_snet" {
  count                = var.function_services_count
  source               = "github.com/pagopa/terraform-azurerm-v4//subnet?ref=v7.20.0"
  name                 = format("%s-services-snet-%d", var.project_itn, count.index + 1)
  address_prefixes     = [var.cidr_subnet_services[count.index]]
  resource_group_name  = var.common_resource_group_name_itn
  virtual_network_name = var.vnet_common_name_itn

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
