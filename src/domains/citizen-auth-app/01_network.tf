data "azurerm_virtual_network" "vnet_common" {
  name                = local.vnet_common_name
  resource_group_name = local.vnet_common_resource_group_name
}

data "azurerm_private_dns_zone" "internal" {
  name                = local.internal_dns_zone_name
  resource_group_name = local.internal_dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "privatelink_azurewebsites_net" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = format("%s-rg-common", local.product)
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


data "azurerm_subnet" "apim_itn_snet" {
  name                 = "io-p-itn-apim-snet-01"
  virtual_network_name = local.vnet_common_name_itn
  resource_group_name  = local.vnet_common_resource_group_name_itn
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

data "azurerm_virtual_network" "common_vnet" {
  name                = format("%s-vnet-common", local.product)
  resource_group_name = format("%s-rg-common", local.product)
}

module "session_manager_snet" {
  source               = "github.com/pagopa/terraform-azurerm-v3//subnet?ref=v8.22.0"
  name                 = format("%s-session-manager-snet-02", local.common_project)
  address_prefixes     = var.cidr_subnet_session_manager
  resource_group_name  = data.azurerm_virtual_network.common_vnet.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.common_vnet.name

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

#########################
# Private Endpoints
#########################

resource "azurerm_private_endpoint" "session_manager_sites" {
  name                = "${local.common_project}-session-manager-app-pep-01"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.session_manager_rg_weu.name
  subnet_id           = data.azurerm_subnet.private_endpoints_subnet.id

  private_service_connection {
    name                           = "${local.common_project}-session-manager-app-pep-01"
    private_connection_resource_id = module.session_manager_weu.id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_azurewebsites_net.id]
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "staging_session_manager_sites" {
  name                = "${local.common_project}-session-manager-staging-app-pep-01"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.session_manager_rg_weu.name
  subnet_id           = data.azurerm_subnet.private_endpoints_subnet.id

  private_service_connection {
    name                           = "${local.common_project}-session-manager-staging-app-pep-01"
    private_connection_resource_id = module.session_manager_weu.id
    is_manual_connection           = false
    subresource_names              = ["sites-${module.session_manager_weu_staging.name}"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_azurewebsites_net.id]
  }

  tags = var.tags
}

data "azurerm_nat_gateway" "nat_gateway" {
  name                = "${local.product}-natgw"
  resource_group_name = format("%s-rg-common", local.product)
}

resource "azurerm_subnet_nat_gateway_association" "session_manager_snet" {
  nat_gateway_id = data.azurerm_nat_gateway.nat_gateway.id
  subnet_id      = module.session_manager_snet.id
}

data "azurerm_resource_group" "rg_external" {
  name = format("%s-rg-external", local.product)
}

data "azurerm_dns_zone" "io_pagopa_it" {
  name                = join(".", [var.dns_zone_io, var.external_domain])
  resource_group_name = data.azurerm_resource_group.rg_external.name
}

data "azurerm_dns_a_record" "api_app_io_pagopa_it" {
  name                = "api-app"
  zone_name           = data.azurerm_dns_zone.io_pagopa_it.name
  resource_group_name = data.azurerm_resource_group.rg_external.name
}
