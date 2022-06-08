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
  public_network_access_enabled = true
  location                      = var.location

  private_endpoint = {
    enabled              = false
    private_dns_zone_ids = []
    subnet_id            = null
    virtual_network_id   = null
  }

  tags = var.tags
}
