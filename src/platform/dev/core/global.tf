module "dns" {
  source = "./_modules/dns"

  dns = {
    resource_groups = {
      common = "${local.project}-common-rg-01"
    }

    vnets = {
      itn = {
        id   = data.azurerm_virtual_network.itn_common.id
        name = "io-d-itn-common-vnet-01"
      }
    }
  }

  tags = local.tags
}
