output "resource_groups" {
  description = <<EOF
  WHAT: All resource groups into itn and weu regions
  EOF
  value = {
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
}