
output "virtual_networks" {
  description = <<EOF
  WHAT: All vnets into itn and weu regions
  EOF
  value = {
    itn = {
      id                  = local.common.virtual_networks.itn.id
      name                = local.common.virtual_networks.itn.name
      resource_group_name = local.common.virtual_networks.itn.resource_group_name
    }
    weu = {
      id                  = local.common.virtual_networks.weu.id
      name                = local.common.virtual_networks.weu.name
      resource_group_name = local.common.virtual_networks.weu.resource_group_name
    }

    prod01 = {
      id                  = local.common.virtual_networks.prod01.id
      name                = local.common.virtual_networks.prod01.name
      resource_group_name = local.common.virtual_networks.prod01.resource_group_name
    }
  }
}

output "pep_subnets" {
  description = <<EOF
  WHAT: Private Endpoint dedicated subnets into itn and weu regions
  EOF
  value = {
    itn = {
      id = local.common.pep_subnets.itn.id
    },
    weu = {
      id = local.common.pep_subnets.weu.id
    }
  }
}

output "dns_zones" {
  description = <<EOF
  WHAT: All common dns zones
  EOF
  value = {
    io_italia = {
      name                = "io.italia.it"
      resource_group_name = "${local.project_weu_legacy}-rg-external"
    }
    io_papopa = {
      name                = "io.pagopa.it"
      resource_group_name = "${local.project_weu_legacy}-rg-external"
    }
    io_selfcare = {
      name                = "io.selfcare.pagopa.it"
      resource_group_name = "${local.project_weu_legacy}-rg-external"
    }
    firmaconio_selfcare = {
      name                = "firmaconio.selfcare.pagopa.it"
      resource_group_name = "${local.project_weu_legacy}-rg-external"
    }
    io_web = {
      name                = "ioapp.it"
      resource_group_name = "${local.project_weu_legacy}-rg-external"
    }
  }
}
