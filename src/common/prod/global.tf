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

      prod01 = {
        id   = data.azurerm_virtual_network.weu_prod01.id
        name = data.azurerm_virtual_network.weu_prod01.name
      }
    }

    dns_default_ttl_sec = 3600

    external_domain = "pagopa.it"

    dns_zones = {
      io                  = "io"
      firmaconio_selfcare = "firmaconio.selfcare"
    }

    app_gateway_public_ip = module.application_gateway_itn.public_ip.address

    apim_private_ip                 = module.apim_itn.private_ips[0]
    platform_api_gateway_private_ip = module.platform_api_gateway_apim_itn.private_ips[0]
  }

  tags = local.tags
}
