## itn-common vnet
data "azurerm_resource_group" "italy_north_common_rg" {
  name = format("%s-itn-common-rg-01", local.product)
}

data "azurerm_virtual_network" "common_vnet_italy_north" {
  name                = format("%s-itn-common-vnet-01", local.product)
  resource_group_name = data.azurerm_resource_group.italy_north_common_rg.name
}

data "azurerm_subnet" "pep" {
  name                 = "${local.common_project_itn}-pep-snet-01"
  virtual_network_name = data.azurerm_virtual_network.common_vnet_italy_north.name
  resource_group_name  = data.azurerm_virtual_network.common_vnet_italy_north.resource_group_name
}

#########################
# Private Endpoints
#########################

## fn-lollipop-itn

resource "azurerm_private_endpoint" "function_lollipop_itn_sites" {
  name                = "${local.common_project_itn}-lollipop-fn-pep-01"
  location            = var.session_manager_location
  resource_group_name = azurerm_resource_group.lollipop_rg_itn.name
  subnet_id           = data.azurerm_subnet.pep.id

  private_service_connection {
    name                           = "${local.common_project_itn}-lollipop-fn-pep-01"
    private_connection_resource_id = module.function_lollipop_itn.id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_azurewebsites_net.id]
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "staging_function_lollipop_itn_sites" {
  name                = "${local.common_project}-lollipop-fn-staging-pep-01"
  location            = var.session_manager_location
  resource_group_name = azurerm_resource_group.lollipop_rg_itn.name
  subnet_id           = data.azurerm_subnet.pep.id

  private_service_connection {
    name                           = "${local.common_project_itn}-lollipop-fn-staging-app-pep-01"
    private_connection_resource_id = module.function_lollipop_itn.id
    is_manual_connection           = false
    subresource_names              = ["sites-${module.function_lollipop_itn.name}"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_azurewebsites_net.id]
  }

  tags = var.tags
}
