module "pep_snet" {
  source               = "github.com/pagopa/terraform-azurerm-v3//subnet?ref=v8.5.0"
  name                 = "${var.project}-pep-snet-001"
  address_prefixes     = var.pep_snet_cidr
  resource_group_name  = var.resource_group_name
  virtual_network_name = module.vnet_itn_common.name

  private_endpoint_network_policies_enabled = false
}