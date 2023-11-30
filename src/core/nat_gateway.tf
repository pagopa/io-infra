# To associate a subnet to this NAT Gateway use azurerm_subnet_nat_gateway_association like here
# Do not use nat_gateway module subnets variable
# resource "azurerm_subnet_nat_gateway_association" "subnet" {
#   nat_gateway_id = module.nat_gateway.id
#   subnet_id      = azurerm_subnet.subnet.id
# }

module "nat_gateway" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//nat_gateway?ref=v7.28.0"

  name                = "${local.project}-natgw"
  location            = azurerm_resource_group.rg_common.location
  resource_group_name = azurerm_resource_group.rg_common.name

  zones = [1]

  public_ips_count = 2

  tags = var.tags
}
