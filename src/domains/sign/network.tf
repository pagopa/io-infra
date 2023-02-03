data "azurerm_virtual_network" "vnet_common" {
  name                = "io-p-vnet-common"
  resource_group_name = "io-p-rg-common"
}

data "azurerm_subnet" "private_endpoints_subnet" {
  name                 = "pendpoints"
  virtual_network_name = "io-p-vnet-common"
  resource_group_name  = "io-p-rg-common"
}

data "azurerm_subnet" "apim" {
  name                 = "apimapi"
  virtual_network_name = "io-p-vnet-common"
  resource_group_name  = "io-p-rg-common"
}

module "io_sign_snet" {
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v4.1.4"
  name                 = format("%s-snet", local.project)
  resource_group_name  = data.azurerm_virtual_network.vnet_common.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name
  address_prefixes     = var.subnets.issuer

  private_endpoint_network_policies_enabled = false

  # network_security_group_id = azurerm_network_security_group.io_sign_issuer_nsg.id

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage",
  ]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_network_security_group" "io_sign_issuer_nsg" {
  name                = format("%s-issuer-nsg", local.project)
  location            = data.azurerm_virtual_network.vnet_common.location
  resource_group_name = data.azurerm_virtual_network.vnet_common.resource_group_name

  tags = var.tags
}

module "io_sign_user_snet" {
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v4.1.4"
  name                 = format("%s-user-snet", local.project)
  resource_group_name  = data.azurerm_virtual_network.vnet_common.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name
  address_prefixes     = var.subnets.user

  private_endpoint_network_policies_enabled = false

  # network_security_group_id = azurerm_network_security_group.io_sign_user_nsg.id

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage",
  ]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_network_security_group" "io_sign_user_nsg" {
  name                = format("%s-user-nsg", local.project)
  location            = data.azurerm_virtual_network.vnet_common.location
  resource_group_name = data.azurerm_virtual_network.vnet_common.resource_group_name

  tags = var.tags
}

module "io_sign_eventhub_snet" {
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v4.1.4"
  name                 = format("%s-eventhub-snet", local.project)
  resource_group_name  = data.azurerm_virtual_network.vnet_common.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name
  address_prefixes     = var.subnets.eventhub

  private_endpoint_network_policies_enabled = false

  service_endpoints = ["Microsoft.EventHub"]
}

resource "azurerm_network_security_group" "io_sign_eventhub_nsg" {
  name                = format("%s-eventhub-nsg", local.project)
  location            = data.azurerm_virtual_network.vnet_common.location
  resource_group_name = data.azurerm_virtual_network.vnet_common.resource_group_name

  tags = var.tags
}

data "azurerm_private_dns_zone" "privatelink_documents_azure_com" {
  name                = "privatelink.documents.azure.com"
  resource_group_name = "io-p-rg-common"
}

data "azurerm_private_dns_zone" "privatelink_blob_core_windows_net" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = "io-p-rg-common"
}

data "azurerm_private_dns_zone" "privatelink_queue_core_windows_net" {
  name                = "privatelink.queue.core.windows.net"
  resource_group_name = "io-p-rg-common"
}

data "azurerm_private_dns_zone" "privatelink_azurewebsites_net" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = "io-p-rg-common"
}

data "azurerm_private_dns_zone" "privatelink_servicebus_windows_net" {
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = "io-p-evt-rg"
}

# Unused at the moment
# data "azurerm_private_dns_zone" "privatelink_file_core_windows_net" {
#   name                = "privatelink.file.core.windows.net"
#   resource_group_name = "io-p-rg-common"
# }

# Unused at the moment
# data "azurerm_private_dns_zone" "privatelink_table_core_windows_net" {
#   name                = "privatelink.table.core.windows.net"
#   resource_group_name = "io-p-rg-common"
# }

resource "azurerm_private_endpoint" "blob" {
  name                = format("%s-blob-endpoint", module.io_sign_storage.name)
  location            = azurerm_resource_group.data_rg.location
  resource_group_name = azurerm_resource_group.data_rg.name
  subnet_id           = data.azurerm_subnet.private_endpoints_subnet.id

  private_service_connection {
    name                           = format("%s-blob", module.io_sign_storage.name)
    private_connection_resource_id = module.io_sign_storage.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_blob_core_windows_net.id]
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "queue" {
  name                = format("%s-queue-endpoint", module.io_sign_storage.name)
  location            = azurerm_resource_group.data_rg.location
  resource_group_name = azurerm_resource_group.data_rg.name
  subnet_id           = data.azurerm_subnet.private_endpoints_subnet.id

  private_service_connection {
    name                           = format("%s-queue", module.io_sign_storage.name)
    private_connection_resource_id = module.io_sign_storage.id
    is_manual_connection           = false
    subresource_names              = ["queue"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_queue_core_windows_net.id]
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "io_sign_user_func" {
  name                = format("%s-endpoint", module.io_sign_user_func.name)
  location            = azurerm_resource_group.data_rg.location
  resource_group_name = azurerm_resource_group.data_rg.name
  subnet_id           = data.azurerm_subnet.private_endpoints_subnet.id

  private_service_connection {
    name                           = format("%s-endpoint", module.io_sign_user_func.name)
    private_connection_resource_id = module.io_sign_user_func.id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_azurewebsites_net.id]
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "io_sign_issuer_func" {
  name                = format("%s-endpoint", module.io_sign_issuer_func.name)
  location            = azurerm_resource_group.data_rg.location
  resource_group_name = azurerm_resource_group.data_rg.name
  subnet_id           = data.azurerm_subnet.private_endpoints_subnet.id

  private_service_connection {
    name                           = format("%s-endpoint", module.io_sign_issuer_func.name)
    private_connection_resource_id = module.io_sign_issuer_func.id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_azurewebsites_net.id]
  }

  tags = var.tags
}
