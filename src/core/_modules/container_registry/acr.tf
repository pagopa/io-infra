module "container_registry" {
  source                        = "github.com/pagopa/terraform-azurerm-v3//container_registry?ref=v8.34.0"
  name                          = local.nonstandard[var.location_short].acr
  sku                           = "Premium"
  resource_group_name           = azurerm_resource_group.container_registry.name
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
