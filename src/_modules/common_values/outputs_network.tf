
output "virtual_networks" {
  description = <<EOF
  WHAT: All vnets into itn and weu regions
  EOF
  value = {
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
}

output "pep_subnets" {
  description = <<EOF
  WHAT: All subnets into itn and weu regions
  EOF
  value = {
    itn = {
      id = local.core.networking.itn.pep_snet.id
    },
    weu = {
      id = local.core.networking.weu.pep_snet.id
    }
  }
}