module "pep_snet" {
  source               = "github.com/pagopa/terraform-azurerm-v3//subnet?ref=v8.27.0"
  name                 = try(local.nonstandard[var.location_short].pep-snet, "${var.project}-pep-snet-01")
  address_prefixes     = var.pep_snet_cidr
  resource_group_name  = var.resource_group_name
  virtual_network_name = module.vnet_common.name

  private_endpoint_network_policies_enabled = false
}
