resource "azurerm_resource_group" "container_registry_rg" {
  name     = format("%s-container-registry-rg", local.project)
  location = var.location

  tags = var.tags
}

module "container_registry" {
  source                        = "git::https://github.com/pagopa/azurerm.git//container_registry?ref=v2.10.0"
  name                          = replace(format("%s-common-acr", local.project), "-", "")
  sku                           = "Premium"
  resource_group_name           = azurerm_resource_group.container_registry_rg.name
  admin_enabled                 = false
  anonymous_pull_enabled        = false
  zone_redundancy_enabled       = true
  public_network_access_enabled = false
  location                      = var.location

  private_endpoint = {
    enabled              = true
    private_dns_zone_ids = [azurerm_private_dns_zone.privatelink_azurecr_io.id]
    subnet_id            = data.azurerm_subnet.private_endpoints_subnet.id
    virtual_network_id   = data.azurerm_virtual_network.vnet_common.id
  }

  tags = var.tags
}
