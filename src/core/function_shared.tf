resource "azurerm_resource_group" "shared_rg" {
  name     = format("%s-shared-rg", local.project)
  location = var.location
}

resource "azurerm_app_service_plan" "shared_plan_1" {
  name                = format("%s-plan-shared-common-1", local.project)
  location            = azurerm_resource_group.shared_rg.location
  resource_group_name = azurerm_resource_group.shared_rg.name

  kind     = var.plan_shared_kind
  reserved = true

  sku {
    tier     = var.plan_shared_sku_tier
    size     = var.plan_shared_sku_size
    capacity = var.plan_shared_sku_capacity
  }

  tags = var.tags
}

# Subnet to host app function
module "shared_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                                           = format("%s-shared-snet", local.project)
  address_prefixes                               = var.cidr_subnet_shared
  resource_group_name                            = data.azurerm_resource_group.vnet_common_rg.name
  virtual_network_name                           = data.azurerm_virtual_network.vnet_common.name
  enforce_private_link_endpoint_network_policies = true

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

#
# Function public
#

data "azurerm_storage_account" "iopstfn3public" {
  name                = "iopstfn3public"
  resource_group_name = azurerm_resource_group.rg_internal.name
}
