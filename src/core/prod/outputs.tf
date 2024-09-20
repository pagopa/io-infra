output "networking" {
  value = {
    itn = module.networking_itn
    weu = module.networking_weu
  }
}

output "key_vault" {
  value = {
    itn = null
    weu = module.key_vault_weu
  }
}

output "resource_groups" {
  value = {
    itn = {
      location   = "italynorth"
      common     = azurerm_resource_group.common_itn.name
      dashboards = azurerm_resource_group.dashboards_itn.name
      github_id  = azurerm_resource_group.github_managed_identity_itn.name
    }
    weu = {
      location = "westeurope"
      common   = azurerm_resource_group.common_weu.name
      internal = azurerm_resource_group.internal_weu.name
      external = azurerm_resource_group.external_weu.name
      sec_weu  = azurerm_resource_group.security.name
    }
  }
}
