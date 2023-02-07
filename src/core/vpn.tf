data "azuread_application" "vpn_app" {
  display_name = format("%s-app-vpn", local.project)
}

## VPN

module "vpn_snet" {
  source                                         = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v4.1.9"
  name                                           = "GatewaySubnet"
  address_prefixes                               = var.cidr_subnet_vpn
  resource_group_name                            = data.azurerm_resource_group.vnet_common_rg.name
  virtual_network_name                           = data.azurerm_virtual_network.vnet_common.name
  service_endpoints                              = []
  enforce_private_link_endpoint_network_policies = true
}

module "vpn" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//vpn_gateway?ref=v4.1.9"

  name                = format("%s-vpn", local.project)
  location            = var.location
  resource_group_name = data.azurerm_resource_group.vnet_common_rg.name
  sku                 = var.vpn_sku
  pip_sku             = var.vpn_pip_sku
  subnet_id           = module.vpn_snet.id

  vpn_client_configuration = [
    {
      address_space         = ["172.16.2.0/24"],
      vpn_client_protocols  = ["OpenVPN"],
      aad_audience          = data.azuread_application.vpn_app.application_id
      aad_issuer            = format("https://sts.windows.net/%s/", data.azurerm_subscription.current.tenant_id)
      aad_tenant            = format("https://login.microsoftonline.com/%s", data.azurerm_subscription.current.tenant_id)
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
  source                                         = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v4.1.9"
  name                                           = format("%s-dnsforwarder", local.project)
  address_prefixes                               = var.cidr_subnet_dnsforwarder
  resource_group_name                            = data.azurerm_resource_group.vnet_common_rg.name
  virtual_network_name                           = data.azurerm_virtual_network.vnet_common.name
  enforce_private_link_endpoint_network_policies = true

  delegation = {
    name = "delegation"
    service_delegation = {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

module "dns_forwarder" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//dns_forwarder?ref=v4.1.9"
  name                = format("%s-dns-forwarder", local.project)
  location            = var.location
  resource_group_name = data.azurerm_resource_group.vnet_common_rg.name
  subnet_id           = module.dns_forwarder_snet.id

  tags = var.tags
}
