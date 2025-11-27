resource "azurerm_public_ip" "this_01" {
  count               = var.ng_ips_number
  name                = format("%s-pip-%02d", try(local.nonstandard[var.location_short].ng, "${var.project}-ng"), count.index + 1)
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  sku_tier            = "Regional"
  zones               = [1]

  tags = var.tags
}

resource "azurerm_public_ip_prefix" "ng" {
  count = var.ng_ippres_number

  name                = format("%s-ippre-%02d", try(local.nonstandard[var.location_short].ng, "${var.project}-ng"), count.index + 1)
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  sku_tier            = "Regional"

  prefix_length = 31
  zones         = [count.index + 1]

  tags = var.tags
}

resource "azurerm_nat_gateway" "this" {
  count = var.ng_number

  name                    = try(local.nonstandard[var.location_short].ng, "${var.project}-ng-0${count.index + 1}")
  location                = var.location
  resource_group_name     = var.resource_group_name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 4
  zones                   = ["${count.index + 1}"]

  tags = var.tags
}

resource "azurerm_nat_gateway_public_ip_association" "this_pip_01" {
  count                = var.ng_ips_number
  nat_gateway_id       = azurerm_nat_gateway.this[0].id
  public_ip_address_id = azurerm_public_ip.this_01[count.index].id
}

resource "azurerm_nat_gateway_public_ip_prefix_association" "this_ippres" {
  count               = var.ng_ippres_number
  nat_gateway_id      = azurerm_nat_gateway.this[count.index].id
  public_ip_prefix_id = azurerm_public_ip_prefix.ng[count.index].id
}
