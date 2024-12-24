output "apim" {
  value = {
    itn = {
      id                      = module.apim_itn.id
      resource_group_common   = local.resource_groups.itn.common
      resource_group_internal = local.resource_groups.itn.internal
    }
    weu = {
      id                      = module.apim_weu.id
      resource_group_common   = local.core.resource_groups.westeurope.common
      resource_group_internal = local.core.resource_groups.westeurope.internal
    }
  }
}

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
    prod01 = {
      id                  = data.azurerm_virtual_network.weu_prod01.id
      name                = data.azurerm_virtual_network.weu_prod01.name
      resource_group_name = data.azurerm_virtual_network.weu_prod01.resource_group_name
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