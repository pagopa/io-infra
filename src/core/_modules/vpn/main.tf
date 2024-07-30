## VPN

module "vpn_snet" {
  source                                    = "github.com/pagopa/terraform-azurerm-v3//subnet?ref=v8.33.0"
  name                                      = "GatewaySubnet"
  address_prefixes                          = var.vpn_cidr_subnet
  resource_group_name                       = var.resource_group_name
  virtual_network_name                      = var.vnet_common.name
  service_endpoints                         = []
  private_endpoint_network_policies_enabled = false
}

module "vpn" {
  source = "github.com/pagopa/terraform-azurerm-v3//vpn_gateway?ref=v8.33.0"

  name                = try(local.nonstandard[var.location_short].vpn, "${var.project}-vpn-01")
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.vpn_sku
  pip_sku             = var.vpn_pip_sku
  subnet_id           = module.vpn_snet.id

  vpn_client_configuration = [
    {
      address_space         = ["172.16.2.0/24"],
      vpn_client_protocols  = ["OpenVPN"],
      aad_audience          = data.azuread_application.vpn_app.application_id
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
  source                                    = "github.com/pagopa/terraform-azurerm-v3//subnet?ref=v8.33.0"
  name                                      = try(local.nonstandard[var.location_short].dns_forwarder_snet, "${var.project}-dns-forwarder-snet-01")
  address_prefixes                          = var.dnsforwarder_cidr_subnet
  resource_group_name                       = var.resource_group_name
  virtual_network_name                      = var.vnet_common.name
  private_endpoint_network_policies_enabled = false

  delegation = {
    name = "delegation"
    service_delegation = {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

module "dns_forwarder" {
  source              = "github.com/pagopa/terraform-azurerm-v3//dns_forwarder?ref=fix-dns-forwarder-import-causes-replacement"
  name                = try(local.nonstandard[var.location_short].dns_forwarder, "${var.project}-dns-forwarder-01")
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = module.dns_forwarder_snet.id

  tags = var.tags
}
