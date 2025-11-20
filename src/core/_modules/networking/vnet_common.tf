resource "azurerm_virtual_network" "common" {
  name                = try(local.nonstandard[var.location_short].vnet, "${var.project}-common-vnet-01")
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = [var.vnet_cidr_block]

  dynamic "ddos_protection_plan" {
    for_each = var.ddos_protection_plan_enabled ? [1] : []
    content {
      id     = local.ddos_protection_plan.id
      enable = var.ddos_protection_plan_enabled
    }
  }

  tags = var.tags
}
