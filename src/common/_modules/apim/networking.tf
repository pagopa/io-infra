resource "azurerm_subnet" "apim" {
  name                 = try(local.nonstandard[var.location_short].snet_name, "${var.project}-apim-snet-01")
  resource_group_name  = var.vnet_common.resource_group_name
  virtual_network_name = var.vnet_common.name
  address_prefixes     = [var.cidr_subnet]

  private_endpoint_network_policies = "Enabled"

  service_endpoints = [
    "Microsoft.Web",
  ]
}

resource "azurerm_network_security_group" "apim" {
  name                = try(local.nonstandard[var.location_short].nsg_name, "${var.project}-apim-nsg-01")
  resource_group_name = var.resource_group_common
  location            = var.location

  security_rule {
    name                       = "managementapim"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3443"
    source_address_prefix      = "ApiManagement"
    destination_address_prefix = "VirtualNetwork"
  }

  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "apim" {
  subnet_id                 = azurerm_subnet.apim.id
  network_security_group_id = azurerm_network_security_group.apim.id
}

resource "azurerm_public_ip" "apim" {
  name                = try(local.nonstandard[var.location_short].pip_name, "${var.project}-apim-pip-01")
  resource_group_name = var.resource_group_common
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "apimio"
  zones               = ["1", "2", "3"]

  tags = var.tags
}
