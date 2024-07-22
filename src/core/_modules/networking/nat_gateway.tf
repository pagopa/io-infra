resource "azurerm_public_ip" "this_01" {
  count = var.ng_ips_number
  name                = format("%s-%02d", try(local.nonstandard[var.location_short].ng, "${var.project}-ng-pip"), count.index + 1)
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  sku_tier            = "Regional"
  zones               = [1]

  tags = var.tags
}

resource "azurerm_nat_gateway" "this" {
  name                    = try(local.nonstandard[var.location_short].ng, "${var.project}-ng-01")
  location                = var.location
  resource_group_name     = var.resource_group_name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 4
  zones                   = [1]

  tags = var.tags
}

resource "azurerm_nat_gateway_public_ip_association" "this_pip_01" {
  count = var.ng_ips_number
  nat_gateway_id       = azurerm_nat_gateway.this.id
  public_ip_address_id = azurerm_public_ip.this_01[count.index].id
}
