resource "azurerm_container_registry" "this" {
  name                          = local.nonstandard[var.location_short].acr
  resource_group_name           = var.resource_group_name
  location                      = var.location
  sku                           = "Premium"
  admin_enabled                 = false
  anonymous_pull_enabled        = false
  zone_redundancy_enabled       = true
  public_network_access_enabled = true

  network_rule_set {
    default_action = "Allow"
    ip_rule        = []
  }

  tags = var.tags
}
