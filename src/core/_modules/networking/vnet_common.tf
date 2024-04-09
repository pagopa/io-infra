module "vnet_in_common" {
  source = "github.com/pagopa/terraform-azurerm-v3//virtual_network?ref=v7.76.0"

  name                = "${var.project}-common-vnet-001"
  location            = var.location
  resource_group_name = var.resource_group_name

  address_space        = [module.subnet_addrs.base_cidr_block]
  ddos_protection_plan = local.ddos_protection_plan

  tags = var.tags
}
