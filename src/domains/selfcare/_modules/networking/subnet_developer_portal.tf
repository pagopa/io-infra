module "snet_developer_portal" {
  source = "github.com/pagopa/terraform-azurerm-v3//subnet?ref=v7.69.1"

  name                 = "${var.project}-devportalservicedata-db-postgresql-snet"
  resource_group_name  = data.azurerm_virtual_network.vnet_common.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name

  address_prefixes                          = [var.cidr_subnet_developer_portal]
  private_endpoint_network_policies_enabled = false
  service_endpoints                         = ["Microsoft.Sql"]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}
