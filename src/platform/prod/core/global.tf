module "dns" {
  source = "./_modules/dns"

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
    }

    external_domain = "pagopa.it"

    dns_zones = {
      io                  = "io"
      firmaconio_selfcare = "firmaconio.selfcare"
    }

    app_gateway_public_ip           = local.app_routing.application_gateway.itn.public_ip
    apim_private_ip                 = local.app_routing.apim.itn.private_ips
    platform_api_gateway_private_ip = local.app_routing.platform_api_gateway.itn.private_ips

  }

  tags = local.tags
}
