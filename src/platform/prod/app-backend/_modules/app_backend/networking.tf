resource "azurerm_subnet" "snet" {
  name                              = try(local.nonstandard[var.location_short].snet, "${var.project}-appbe-${var.name}-snet-01")
  address_prefixes                  = var.cidr_subnet
  resource_group_name               = var.resource_group_common
  virtual_network_name              = var.vnet_common.name
  private_endpoint_network_policies = "Enabled"

  service_endpoints = [
    "Microsoft.Web",
  ]

  delegation {
    name = "default"
    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet_nat_gateway_association" "snet" {
  for_each       = { for ng in var.nat_gateways : ng.id => ng }
  nat_gateway_id = each.key
  subnet_id      = azurerm_subnet.snet.id
}

resource "azurerm_private_endpoint" "app_backend" {
  name                = format("${var.project}-weu-appbackend-app-pep-%02d", var.index)
  location            = var.location
  resource_group_name = var.resource_group_linux
  subnet_id           = var.subnet_pep_id

  private_service_connection {
    name                           = format("${var.project}-weu-appbackend-app-pep-%02d", var.index)
    private_connection_resource_id = module.appservice_app_backend.id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [var.private_dns_zone_id]
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "app_backend_staging" {
  name                = format("${var.project}-weu-appbackend-staging-app-pep-%02d", var.index)
  location            = var.location
  resource_group_name = var.resource_group_linux
  subnet_id           = var.subnet_pep_id

  private_service_connection {
    name                           = format("${var.project}-weu-appbackend-staging-app-pep-%02d", var.index)
    private_connection_resource_id = module.appservice_app_backend.id
    is_manual_connection           = false
    subresource_names              = ["sites-${module.appservice_app_backend_slot_staging.name}"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [var.private_dns_zone_id]
  }

  tags = var.tags
}
