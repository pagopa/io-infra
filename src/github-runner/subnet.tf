module "subnet_runner" {
  source = "github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.46.0"

  name                 = "${local.project}-github-runner-snet"
  resource_group_name  = data.azurerm_resource_group.rg_common.name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name

  address_prefixes = [
    "${var.networking.subnet_cidr_block}"
  ]

  service_endpoints = [
    "Microsoft.Web"
  ]

  private_endpoint_network_policies_enabled = true
}
