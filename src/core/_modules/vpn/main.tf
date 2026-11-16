resource "azurerm_subnet" "vpn" {
  name                 = "GatewaySubnet"
  address_prefixes     = var.vpn_cidr_subnet
  virtual_network_name = var.vnet_common.name
  resource_group_name  = var.resource_group_name
}

resource "azurerm_public_ip" "vpn_gw" {
  name                = "${var.project}-vpn-gw-pip"
  resource_group_name = var.resource_group_name
  location            = var.location

  domain_name_label = "${replace(var.project, "-", "")}vpngw${random_string.dns.result}"
  allocation_method = "Static"
  sku               = var.vpn_pip_sku
  sku_tier          = "Regional"

  tags = var.tags
}

resource "random_string" "dns" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_virtual_network_gateway" "vpn_gw" {
  name                = "${var.project}-vpn-gw"
  resource_group_name = var.resource_group_name
  location            = var.location
  type                = "Vpn"
  sku                 = var.vpn_sku

  ip_configuration {
    name                          = "${var.project}-vpn-gw-config"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vpn_gw.id
    subnet_id                     = azurerm_subnet.vpn.id
  }

  vpn_client_configuration {
    address_space         = ["172.16.2.0/24"]
    vpn_client_protocols  = ["OpenVPN"]
    aad_audience          = data.azuread_application.vpn_app.client_id
    aad_issuer            = "https://sts.windows.net/${var.subscription_current.tenant_id}/"
    aad_tenant            = "https://login.microsoftonline.com/${var.subscription_current.tenant_id}"
    radius_server_address = null
    radius_server_secret  = null
  }

  tags = var.tags
}
