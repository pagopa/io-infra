resource "azurerm_public_ip" "this_01" {
  name                = "${var.project}-ng-pip-01"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  sku_tier            = "Regional"
  zones               = [1]

  tags = var.tags
}

resource "azurerm_public_ip" "this_02" {
  name                = "${var.project}-ng-pip-02"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  sku_tier            = "Regional"
  zones               = [2]

  tags = var.tags
}

resource "azurerm_public_ip" "this_03" {
  name                = "${var.project}-ng-pip-03"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  sku_tier            = "Regional"
  zones               = [3]

  tags = var.tags
}

resource "azurerm_nat_gateway" "this_01" {
  name                    = "${var.project}-ng-01"
  location                = var.location
  resource_group_name     = var.resource_group_name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 4
  zones                   = [1]

  tags = var.tags
}

resource "azurerm_nat_gateway" "this_02" {
  name                    = "${var.project}-ng-02"
  location                = var.location
  resource_group_name     = var.resource_group_name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 4
  zones                   = [2]

  tags = var.tags
}

resource "azurerm_nat_gateway" "this_03" {
  name                    = "${var.project}-ng-03"
  location                = var.location
  resource_group_name     = var.resource_group_name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 4
  zones                   = [3]

  tags = var.tags
}

resource "azurerm_nat_gateway_public_ip_association" "this_01" {
  nat_gateway_id       = azurerm_nat_gateway.this_01.id
  public_ip_address_id = azurerm_public_ip.this_01.id
}

resource "azurerm_nat_gateway_public_ip_association" "this_02" {
  nat_gateway_id       = azurerm_nat_gateway.this_02.id
  public_ip_address_id = azurerm_public_ip.this_02.id
}

resource "azurerm_nat_gateway_public_ip_association" "this_03" {
  nat_gateway_id       = azurerm_nat_gateway.this_03.id
  public_ip_address_id = azurerm_public_ip.this_03.id
}
