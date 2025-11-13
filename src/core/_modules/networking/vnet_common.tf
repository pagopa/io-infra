resource "azurerm_virtual_network" "common" {
  name                = try(local.nonstandard[var.location_short].vnet, "${var.project}-common-vnet-01")
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = [var.vnet_cidr_block]

  # ddos_protection_plan {
  #   id     = local.ddos_protection_plan.id
  #   enable = local.ddos_protection_plan.enable
  # }

  tags = var.tags
}
