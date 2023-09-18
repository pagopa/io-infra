data "azurerm_virtual_network" "vnet_common" {
  name                = local.vnet_common_name
  resource_group_name = local.vnet_common_resource_group_name
}

data "azurerm_private_dns_zone" "privatelink_redis_cache" {
  name                = "privatelink.redis.cache.windows.net"
  resource_group_name = format("%s-rg-common", local.product)
  tags                = var.tags
}

data "azurerm_subnet" "azdoa_snet" {
  name                 = "azure-devops"
  virtual_network_name = local.vnet_common_name
  resource_group_name  = local.vnet_common_resource_group_name
}

data "azurerm_subnet" "apim_v2_snet" {
  name                 = "apimv2api"
  virtual_network_name = local.vnet_common_name
  resource_group_name  = local.vnet_common_resource_group_name
}

data "azurerm_subnet" "ioweb_profile_snet" {
  name                 = format("%s-ioweb-profile-snet", local.product)
  virtual_network_name = local.vnet_common_name
  resource_group_name  = local.vnet_common_resource_group_name
}

## redis spid login subnet
module "redis_spid_login_snet" {
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v4.1.15"
  name                 = format("%s-redis-spid-login-snet", local.project)
  address_prefixes     = var.subnets_cidrs.redis_spid_login
  resource_group_name  = local.vnet_common_resource_group_name
  virtual_network_name = local.vnet_common_name

  private_endpoint_network_policies_enabled = false
}

## spid_login subnet
module "spid_login_snet" {
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v4.1.15"
  name                 = format("%s-spid-login-snet", local.project)
  address_prefixes     = var.subnets_cidrs.spid_login
  resource_group_name  = local.vnet_common_resource_group_name
  virtual_network_name = local.vnet_common_name

  private_endpoint_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.Web",
  ]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}
