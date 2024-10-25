resource "azurerm_resource_group" "shared_rg_itn" {
  name     = format("%s-shared-rg-01", local.project_itn)
  location = local.itn_location
}

resource "azurerm_app_service_plan" "shared_plan_itn" {
  name                = format("%s-shared-asp-01", local.project_itn)
  location            = azurerm_resource_group.shared_rg_itn.location
  resource_group_name = azurerm_resource_group.shared_rg_itn.name

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
module "shared_snet_itn" {
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v8.44.1"
  name                                      = format("%s-shared-snet-01", local.project_itn)
  address_prefixes                          = var.cidr_subnet_shared_1
  resource_group_name                       = local.vnet_common_resource_group_name_itn
  virtual_network_name                      = local.vnet_common_name_itn
  private_endpoint_network_policies_enabled = true

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}
