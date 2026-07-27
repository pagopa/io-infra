output "private_endpoints" {
  value = module.private_endpoints.private_endpoints
}

output "virtual_networks" {
  value = {
    weu = {
      id                  = local.core.networking.weu.vnet_common.id
      name                = local.core.networking.weu.vnet_common.name
      resource_group_name = local.core.networking.weu.vnet_common.resource_group_name
    }
    itn = {
      id                  = local.core.networking.itn.vnet_common.id
      name                = local.core.networking.itn.vnet_common.name
      resource_group_name = local.core.networking.itn.vnet_common.resource_group_name
    }
  }
}

output "pep_subnets" {
  value = {
    itn = {
      id = local.core.networking.itn.pep_snet.id
    },
    weu = {
      id = local.core.networking.weu.pep_snet.id
    }
  }
}

output "github_runner" {
  value = {
    itn = {
      subnet_id = module.github_runner_itn.subnet.id
    }
  }
}
