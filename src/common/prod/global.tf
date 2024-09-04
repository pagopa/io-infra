module "global" {
  source = "../_modules/global"

  project = local.project_weu_legacy

  dns = {
    resource_groups = {
      common   = "${local.project_weu_legacy}-rg-common"
      internal = "${local.project_weu_legacy}-rg-internal"
      external = "${local.project_weu_legacy}-rg-external"
      event    = "${local.project_weu_legacy}-evt-rg"
    }

    vnets = {
      weu = {
        id   = local.core.networking.weu.vnet_common.id
        name = local.core.networking.weu.vnet_common.name
      }

      itn = {
        id   = local.core.networking.itn.vnet_common.id
        name = local.core.networking.itn.vnet_common.name
      }

      beta = {
        id   = data.azurerm_virtual_network.weu_beta.id
        name = data.azurerm_virtual_network.weu_beta.name
      }

      prod01 = {
        id   = data.azurerm_virtual_network.weu_prod01.id
        name = data.azurerm_virtual_network.weu_prod01.name
      }
    }

    dns_default_ttl_sec = 3600

    external_domain = "pagopa.it"

    dns_zones = {
      io                  = "io"
      io_selfcare         = "io.selfcare"
      firmaconio_selfcare = "firmaconio.selfcare"
    }

    # TODO: remove when app gateway module is implemented
    app_gateway_public_ip = data.azurerm_public_ip.appgateway_public_ip.ip_address

    # TODO: remove when apim v2 module is implemented
    apim_v2_private_ip = data.azurerm_api_management.apim_v2.private_ip_addresses[0]
  }

  tags = merge(local.tags, { Source = "https://github.com/pagopa/io-infra" })
}
