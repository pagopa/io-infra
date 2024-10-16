locals {
  # General
  prefix             = "io"
  env_short          = "p"
  location_short     = { westeurope = "weu", italynorth = "itn" }
  project_itn        = "${local.prefix}-${local.env_short}-${local.location_short.italynorth}"
  project_weu        = "${local.prefix}-${local.env_short}-${local.location_short.westeurope}"
  project_weu_legacy = "${local.prefix}-${local.env_short}"
  core               = data.terraform_remote_state.core.outputs

  #---------#
  # OUTPUTS #
  #---------#

  # WHAT: Name and configuration for gates on release, to be changed at each release with the most up-to-date values
  # HOW: These values ​​will be used for scaling the different resources (function app, app services, etc.)
  scaling_gate = {
    name     = "gate1"
    timezone = "W. Europe Standard Time"
    start    = "2024-10-23T08:00:00.000Z"
    end      = "2024-10-23T22:00:00.000Z"
  }


  # WHAT: All resource gorups into itn and weu regions
  resource_groups = {
    weu = {
      common     = "${local.project_weu_legacy}-rg-common"
      internal   = "${local.project_weu_legacy}-rg-internal"
      external   = "${local.project_weu_legacy}-rg-external"
      event      = "${local.project_weu_legacy}-evt-rg"
      sec        = "${local.project_weu_legacy}-sec-rg"
      linux      = "${local.project_weu_legacy}-rg-linux"
      assets_cdn = local.core.resource_groups.westeurope.assets_cdn
      acr        = local.core.resource_groups.westeurope.acr
    },
    itn = {
      common     = "${local.project_itn}-common-rg-01"
      internal   = "${local.project_itn}-common-rg-01"
      external   = "${local.project_itn}-common-rg-01"
      event      = "${local.project_itn}-common-rg-01"
      sec        = "${local.project_itn}-sec-rg-01"
      linux      = "${local.project_itn}-common-rg-01"
      dashboards = local.core.resource_groups.italynorth.dashboards
      github_id  = local.core.resource_groups.italynorth.github_id
    }
  }

  # WHAT: All vnets into itn and weu regions
  virtual_networks = {
    itn = {
      common = local.core.networking.itn.vnet_common
    }
    weu = {
      common = local.core.networking.weu.vnet_common
      beta = {
        name                = data.azurerm_virtual_network.weu_beta.name
        resource_group_name = data.azurerm_virtual_network.weu_beta.resource_group_name
      }
      prod01 = {
        name                = data.azurerm_virtual_network.weu_prod01.name
        resource_group_name = data.azurerm_virtual_network.weu_prod01.resource_group_name
      }
    }
  }

  # WHAT: All subnets into itn and weu regions
  pep_subnets = {
    itn = {
      id = local.core.networking.itn.pep_snet.id
    },
    weu = {
      id = local.core.networking.weu.pep_snet.id
    }
  }
}