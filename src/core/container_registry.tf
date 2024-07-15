resource "azurerm_resource_group" "container_registry_rg" {
  name     = format("%s-container-registry-rg", local.project)
  location = var.location

  tags = var.tags
}

module "container_registry" {
  source                        = "github.com/pagopa/terraform-azurerm-v3//container_registry?ref=v8.27.0"
  name                          = replace(format("%s-common-acr", local.project), "-", "")
  sku                           = "Premium"
  resource_group_name           = azurerm_resource_group.container_registry_rg.name
  admin_enabled                 = false
  anonymous_pull_enabled        = false
  zone_redundancy_enabled       = true
  public_network_access_enabled = true
  location                      = var.location

  private_endpoint_enabled = false
  private_endpoint = {
    private_dns_zone_ids = []
    subnet_id            = null
    virtual_network_id   = null
  }

  network_rule_set = [{
    default_action  = "Allow"
    ip_rule         = []
    virtual_network = []
  }]

  tags = var.tags
}
