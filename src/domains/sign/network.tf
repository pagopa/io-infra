data "azurerm_virtual_network" "vnet_common" {
  name                = format("%s-vnet-common", local.product)
  resource_group_name = format("%s-rg-common", local.product)
}

data "azurerm_virtual_network" "itn_vnet_common" {
  name                = format("%s-itn-common-vnet-01", local.product)
  resource_group_name = format("%s-itn-common-rg-01", local.product)
}

data "azurerm_subnet" "private_endpoints_subnet" {
  name                 = "pendpoints"
  virtual_network_name = format("%s-vnet-common", local.product)
  resource_group_name  = format("%s-rg-common", local.product)
}

data "azurerm_subnet" "itn_private_endpoints_subnet" {
  name                 = format("%s-itn-pep-snet-01", local.product)
  virtual_network_name = data.azurerm_virtual_network.itn_vnet_common.name
  resource_group_name  = data.azurerm_virtual_network.itn_vnet_common.resource_group_name
}

data "azurerm_subnet" "apim_v2" {
  name                 = "apimv2api"
  virtual_network_name = format("%s-vnet-common", local.product)
  resource_group_name  = format("%s-rg-common", local.product)
}

data "azurerm_nat_gateway" "nat_gateway" {
  name                = format("%s-natgw", local.product)
  resource_group_name = format("%s-rg-common", local.product)
}

module "io_sign_snet" {
  source               = "github.com/pagopa/terraform-azurerm-v3//subnet?ref=v8.35.0"
  name                 = format("%s-snet", local.project)
  resource_group_name  = data.azurerm_virtual_network.vnet_common.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name
  address_prefixes     = var.subnets_cidrs.issuer

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

resource "azurerm_subnet_nat_gateway_association" "io_sign_issuer_snet" {
  nat_gateway_id = data.azurerm_nat_gateway.nat_gateway.id
  subnet_id      = module.io_sign_snet.id
}

resource "azurerm_network_security_group" "io_sign_issuer_nsg" {
  name                = format("%s-issuer-nsg", local.project)
  location            = data.azurerm_virtual_network.vnet_common.location
  resource_group_name = data.azurerm_virtual_network.vnet_common.resource_group_name

  tags = var.tags
}

module "io_sign_user_snet" {
  source               = "github.com/pagopa/terraform-azurerm-v3//subnet?ref=v8.35.0"
  name                 = format("%s-user-snet", local.project)
  resource_group_name  = data.azurerm_virtual_network.vnet_common.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name
  address_prefixes     = var.subnets_cidrs.user

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

resource "azurerm_subnet_nat_gateway_association" "io_sign_user_snet" {
  nat_gateway_id = data.azurerm_nat_gateway.nat_gateway.id
  subnet_id      = module.io_sign_user_snet.id
}

resource "azurerm_network_security_group" "io_sign_user_nsg" {
  name                = format("%s-user-nsg", local.project)
  location            = data.azurerm_virtual_network.vnet_common.location
  resource_group_name = data.azurerm_virtual_network.vnet_common.resource_group_name

  tags = var.tags
}

module "io_sign_support_snet" {
  source               = "github.com/pagopa/terraform-azurerm-v3//subnet?ref=v8.35.0"
  name                 = format("%s-support-snet", local.project)
  resource_group_name  = data.azurerm_virtual_network.vnet_common.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name
  address_prefixes     = var.subnets_cidrs.support

  private_endpoint_network_policies_enabled = false

  # network_security_group_id = azurerm_network_security_group.io_sign_user_nsg.id

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
  ]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet_nat_gateway_association" "io_sign_support_snet" {
  nat_gateway_id = data.azurerm_nat_gateway.nat_gateway.id
  subnet_id      = module.io_sign_support_snet.id
}

resource "azurerm_network_security_group" "io_sign_support_nsg" {
  name                = format("%s-support-nsg", local.project)
  location            = data.azurerm_virtual_network.vnet_common.location
  resource_group_name = data.azurerm_virtual_network.vnet_common.resource_group_name

  tags = var.tags
}

module "io_sign_eventhub_snet" {
  source               = "github.com/pagopa/terraform-azurerm-v3//subnet?ref=v8.35.0"
  name                 = format("%s-eventhub-snet", local.project)
  resource_group_name  = data.azurerm_virtual_network.vnet_common.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name
  address_prefixes     = var.subnets_cidrs.eventhub

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

data "azurerm_private_dns_zone" "privatelink_azurewebsites_net" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = format("%s-rg-common", local.product)
}

data "azurerm_private_dns_zone" "privatelink_servicebus_windows_net" {
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = format("%s-evt-rg", local.product)
}

# Unused at the moment
# tflint-ignore: terraform_unused_declarations
data "azurerm_private_dns_zone" "privatelink_file_core_windows_net" {
  name                = "privatelink.file.core.windows.net"
  resource_group_name = format("%s-rg-common", local.product)
}

# Unused at the moment
# tflint-ignore: terraform_unused_declarations
data "azurerm_private_dns_zone" "privatelink_table_core_windows_net" {
  name                = "privatelink.table.core.windows.net"
  resource_group_name = format("%s-rg-common", local.product)
}

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

resource "azurerm_private_endpoint" "itn_blob" {
  name                = format("%s-itn-sign-blob-pep-01", local.product)
  location            = azurerm_resource_group.sign.location
  resource_group_name = azurerm_resource_group.sign.name
  subnet_id           = data.azurerm_subnet.itn_private_endpoints_subnet.id

  private_service_connection {
    name                           = format("%s-itn-sign-blob-pep-01", local.product)
    private_connection_resource_id = module.io_sign_storage_itn.id
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

resource "azurerm_private_endpoint" "itn_queue" {
  name                = format("%s-itn-sign-queue-pep-01", local.product)
  location            = azurerm_resource_group.sign.location
  resource_group_name = azurerm_resource_group.sign.name
  subnet_id           = data.azurerm_subnet.itn_private_endpoints_subnet.id

  private_service_connection {
    name                           = format("%s-itn-sign-queue-pep-01", local.product)
    private_connection_resource_id = module.io_sign_storage_itn.id
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

resource "azurerm_private_endpoint" "io_sign_user_func_staging" {
  count = var.io_sign_user_func.sku_tier == "PremiumV3" ? 1 : 0

  name                = format("%s-staging-endpoint", module.io_sign_user_func.name)
  location            = azurerm_resource_group.data_rg.location
  resource_group_name = azurerm_resource_group.data_rg.name
  subnet_id           = data.azurerm_subnet.private_endpoints_subnet.id

  private_service_connection {
    name                           = format("%s-staging-endpoint", module.io_sign_user_func.name)
    private_connection_resource_id = module.io_sign_user_func.id
    is_manual_connection           = false
    subresource_names              = ["sites-staging"]
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

resource "azurerm_private_endpoint" "io_sign_issuer_func_staging" {
  count = var.io_sign_issuer_func.sku_tier == "PremiumV3" ? 1 : 0

  name                = format("%s-staging-endpoint", module.io_sign_issuer_func.name)
  location            = azurerm_resource_group.data_rg.location
  resource_group_name = azurerm_resource_group.data_rg.name
  subnet_id           = data.azurerm_subnet.private_endpoints_subnet.id

  private_service_connection {
    name                           = format("%s-staging-endpoint", module.io_sign_issuer_func.name)
    private_connection_resource_id = module.io_sign_issuer_func.id
    is_manual_connection           = false
    subresource_names              = ["sites-staging"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_azurewebsites_net.id]
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "io_sign_support_func" {
  name                = format("%s-endpoint", module.io_sign_support_func.name)
  location            = azurerm_resource_group.data_rg.location
  resource_group_name = azurerm_resource_group.data_rg.name
  subnet_id           = data.azurerm_subnet.private_endpoints_subnet.id

  private_service_connection {
    name                           = format("%s-endpoint", module.io_sign_support_func.name)
    private_connection_resource_id = module.io_sign_support_func.id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_azurewebsites_net.id]
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "io_sign_support_func_staging" {
  count = var.io_sign_support_func.sku_tier == "PremiumV3" ? 1 : 0

  name                = format("%s-staging-endpoint", module.io_sign_support_func.name)
  location            = azurerm_resource_group.data_rg.location
  resource_group_name = azurerm_resource_group.data_rg.name
  subnet_id           = data.azurerm_subnet.private_endpoints_subnet.id

  private_service_connection {
    name                           = format("%s-staging-endpoint", module.io_sign_support_func.name)
    private_connection_resource_id = module.io_sign_support_func.id
    is_manual_connection           = false
    subresource_names              = ["sites-staging"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_azurewebsites_net.id]
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "io_sign_backoffice_func_staging" {

  name                = format("%s-staging-endpoint", module.io_sign_backoffice_func.name)
  location            = azurerm_resource_group.data_rg.location
  resource_group_name = azurerm_resource_group.data_rg.name
  subnet_id           = data.azurerm_subnet.private_endpoints_subnet.id

  private_service_connection {
    name                           = format("%s-staging-endpoint", module.io_sign_backoffice_func.name)
    private_connection_resource_id = module.io_sign_backoffice_func.id
    is_manual_connection           = false
    subresource_names              = ["sites-staging"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_azurewebsites_net.id]
  }

  tags = var.tags
}
