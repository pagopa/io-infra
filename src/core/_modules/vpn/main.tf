resource "azurerm_subnet" "vpn" {
  name                 = "GatewaySubnet"
  address_prefixes     = var.vpn_cidr_subnet
  virtual_network_name = var.vnet_common.name
  resource_group_name  = var.resource_group_name
}

module "vpn" {
  source = "github.com/pagopa/terraform-azurerm-v4//vpn_gateway?ref=v7.52.0"

  name                = try(local.nonstandard[var.location_short].vpn, "${var.project}-vgw-01")
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.vpn_sku
  pip_sku             = var.vpn_pip_sku
  subnet_id           = azurerm_subnet.vpn.id

  vpn_client_configuration = [
    {
      address_space         = ["172.16.2.0/24"],
      vpn_client_protocols  = ["OpenVPN"],
      aad_audience          = data.azuread_application.vpn_app.client_id
      aad_issuer            = "https://sts.windows.net/${var.subscription_current.tenant_id}/"
      aad_tenant            = "https://login.microsoftonline.com/${var.subscription_current.tenant_id}"
      radius_server_address = null
      radius_server_secret  = null
      revoked_certificate   = []
      root_certificate      = []
    }
  ]

  tags = var.tags
}

## DNS FORWARDER
module "dns_forwarder_snet" {
  source                                    = "github.com/pagopa/terraform-azurerm-v4//subnet?ref=v7.52.0"
  name                                      = try(local.nonstandard[var.location_short].dns_forwarder_snet, "${var.project}-dns-forwarder-snet-01")
  address_prefixes                          = var.dnsforwarder_cidr_subnet
  resource_group_name                       = var.resource_group_name
  virtual_network_name                      = var.vnet_common.name
  private_endpoint_network_policies_enabled = "Disabled"

  delegation = {
    name = "delegation"
    service_delegation = {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

module "dns_forwarder" {
  source              = "github.com/pagopa/terraform-azurerm-v4//dns_forwarder_deprecated?ref=v7.52.0"
  name                = try(local.nonstandard[var.location_short].dns_forwarder, "${var.project}-dns-forwarder-ci-01")
  location            = var.location
  resource_group_name = var.resource_group_name

  # workaround to avoid the intention to replace the resource because of the capitalization of the name
  subnet_id = "/subscriptions/${upper(var.subscription_current.subscription_id)}/resourceGroups/${upper(var.resource_group_name)}/providers/Microsoft.Network/virtualNetworks/${upper(var.vnet_common.name)}/subnets/${upper(module.dns_forwarder_snet.name)}"

  tags = var.tags
}
