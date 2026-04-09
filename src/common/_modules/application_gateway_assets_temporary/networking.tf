resource "azurerm_subnet" "agw" {
  name                 = "${var.project}-assets-agw-snet-01"
  resource_group_name  = var.resource_group_common
  virtual_network_name = var.vnet_common.name
  address_prefixes     = var.cidr_subnet
}

resource "azurerm_public_ip" "agw" {
  name                = "${var.project}-assets-agw-pip-01"
  resource_group_name = var.resource_group_common
  location            = var.location
  sku                 = "Standard"
  allocation_method   = "Static"
  zones               = [1, 2, 3]

  tags = var.tags
}

resource "azurerm_dns_a_record" "public_ip_a_record" {

  name                = "redirect.assets.cdn"
  zone_name           = var.public_dns_zones.io.name
  resource_group_name = var.resource_group_external
  ttl                 = 60
  target_resource_id  = azurerm_public_ip.agw.id
}
