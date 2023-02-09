resource "azurerm_resource_group" "shared_rg" {
  name     = format("%s-shared-rg", local.project)
  location = var.location
}

resource "azurerm_app_service_plan" "shared_1_plan" {
  name                = format("%s-plan-shared-1-common", local.project)
  location            = azurerm_resource_group.shared_rg.location
  resource_group_name = azurerm_resource_group.shared_rg.name

  kind     = var.plan_shared_1_kind
  reserved = true

  sku {
    tier     = var.plan_shared_1_sku_tier
    size     = var.plan_shared_1_sku_size
    capacity = var.plan_shared_1_sku_capacity
  }

  tags = var.tags
}

# Subnet to host app function
module "shared_1_snet" {
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v4.1.12"
  name                                      = format("%s-shared-1-snet", local.project)
  address_prefixes                          = var.cidr_subnet_shared_1
  resource_group_name                       = data.azurerm_resource_group.vnet_common_rg.name
  virtual_network_name                      = data.azurerm_virtual_network.vnet_common.name
  private_endpoint_network_policies_enabled = false

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
