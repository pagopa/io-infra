data "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  resource_group_name = local.vnet_resource_group_name
}

data "azurerm_virtual_network" "vnet_common" {
  name                = local.vnet_common_name
  resource_group_name = local.vnet_common_resource_group_name
}

data "azurerm_private_dns_zone" "internal" {
  name                = local.internal_dns_zone_name
  resource_group_name = local.internal_dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "privatelink_blob_core_windows_net" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = format("%s-rg-common", local.product)
}

data "azurerm_private_dns_zone" "privatelink_queue_core_windows_net" {
  name                = "privatelink.queue.core.windows.net"
  resource_group_name = format("%s-rg-common", local.product)
}

data "azurerm_private_dns_zone" "privatelink_file_core_windows_net" {
  name                = "privatelink.file.core.windows.net"
  resource_group_name = format("%s-rg-common", local.product)
}

data "azurerm_private_dns_zone" "privatelink_table_core_windows_net" {
  name                = "privatelink.table.core.windows.net"
  resource_group_name = format("%s-rg-common", local.product)
}

data "azurerm_private_dns_zone" "privatelink_documents_azure_com" {
  name                = "privatelink.documents.azure.com"
  resource_group_name = format("%s-rg-common", local.product)
}

data "azurerm_private_dns_zone" "privatelink_mongo_cosmos_azure_com" {
  name                = "privatelink.mongo.cosmos.azure.com"
  resource_group_name = format("%s-rg-common", local.product)
}

resource "azurerm_private_dns_a_record" "ingress" {
  name                = local.ingress_hostname
  zone_name           = data.azurerm_private_dns_zone.internal.name
  resource_group_name = local.internal_dns_zone_resource_group_name
  ttl                 = 3600
  records             = [var.ingress_load_balancer_ip]
}

data "azurerm_subnet" "private_endpoints_subnet" {
  name                 = "pendpoints"
  virtual_network_name = local.vnet_common_name
  resource_group_name  = local.vnet_common_resource_group_name
}

data "azurerm_subnet" "app_backend_l1_snet" {
  name                 = "appbackendl1"
  virtual_network_name = local.vnet_common_name
  resource_group_name  = local.vnet_common_resource_group_name
}

data "azurerm_subnet" "app_backend_l2_snet" {
  name                 = "appbackendl2"
  virtual_network_name = local.vnet_common_name
  resource_group_name  = local.vnet_common_resource_group_name
}

data "azurerm_subnet" "ioweb_profile_snet" {
  name                 = format("%s-ioweb-profile-snet", local.common_project)
  virtual_network_name = local.vnet_common_name
  resource_group_name  = local.vnet_common_resource_group_name
}

data "azurerm_subnet" "apim_v2_snet" {
  name                 = "apimv2api"
  virtual_network_name = local.vnet_common_name
  resource_group_name  = local.vnet_common_resource_group_name
}

data "azurerm_subnet" "azdoa_snet" {
  count                = var.enable_azdoa ? 1 : 0
  name                 = "azure-devops"
  virtual_network_name = local.vnet_common_name
  resource_group_name  = local.vnet_common_resource_group_name
}

data "azurerm_subnet" "appgateway_snet" {
  name                 = "io-p-appgateway-snet"
  virtual_network_name = local.vnet_common_name
  resource_group_name  = local.vnet_common_resource_group_name
}

data "azurerm_subnet" "self_hosted_runner_snet" {
  name                 = "io-p-github-runner-snet"
  virtual_network_name = local.vnet_common_name
  resource_group_name  = local.vnet_common_resource_group_name
}

## session_manager subnet
data "azurerm_resource_group" "italy_north_common_rg" {
  name = format("%s-itn-common-rg-001", local.product)
}

data "azurerm_virtual_network" "common_vnet_italy_north" {
  name                = format("%s-itn-common-vnet-001", local.product)
  resource_group_name = data.azurerm_resource_group.italy_north_common_rg.name
}

module "session_manager_snet" {
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v8.4.0"
  name                 = format("%s-session-manager-snet-001", local.common_session_manager_project)
  address_prefixes     = var.cidr_subnet_session_manager
  resource_group_name  = data.azurerm_resource_group.italy_north_common_rg.name
  virtual_network_name = data.azurerm_virtual_network.common_vnet_italy_north.name

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
