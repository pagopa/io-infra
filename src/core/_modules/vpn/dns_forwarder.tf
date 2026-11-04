resource "azurerm_subnet" "dns_forwarder" {
  name                              = "${var.project}-dnsforwarder"
  address_prefixes                  = var.dnsforwarder_cidr_subnet
  resource_group_name               = var.resource_group_name
  virtual_network_name              = var.vnet_common.name
  private_endpoint_network_policies = "Disabled"

  delegation {
    name = "delegation"
    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }

}

resource "azurerm_container_group" "dns_forwarder" {
  name                = "${var.project}-dns-forwarder"
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_address_type     = "Private"
  os_type             = "Linux"
  sku                 = "Standard"

  subnet_ids = [
    # workaround to avoid the intention to replace the resource because of the capitalization of the name
    "/subscriptions/${upper(var.subscription_current.subscription_id)}/resourceGroups/${upper(var.resource_group_name)}/providers/Microsoft.Network/virtualNetworks/${upper(var.vnet_common.name)}/subnets/${upper(azurerm_subnet.dns_forwarder.name)}"
  ]

  container {
    name   = "dns-forwarder"
    image  = "coredns/coredns:1.10.1@sha256:be7652ce0b43b1339f3d14d9b14af9f588578011092c1f7893bd55432d83a378"
    cpu    = 0.5
    memory = 0.5

    commands = [
      "/coredns",
      "-conf",
      "/app/conf/Corefile"
    ]

    ports {
      port     = 53
      protocol = "UDP"
    }

    volume {
      empty_dir  = false
      mount_path = "/app/conf"
      name       = "dns-forwarder-conf"
      read_only  = true
    }
  }

  tags = var.tags
}