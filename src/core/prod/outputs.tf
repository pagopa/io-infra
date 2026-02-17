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
    italynorth = {
      location_short = "itn"
      common         = azurerm_resource_group.common_itn.name
      dashboards     = azurerm_resource_group.dashboards_itn.name
      github_id      = azurerm_resource_group.github_managed_identity_itn.name
      external       = azurerm_resource_group.external_itn.name
      assets_cdn     = azurerm_resource_group.assets_cdn_itn.name
    }
    westeurope = {
      location_short = "weu"
      common         = azurerm_resource_group.common_weu.name
      internal       = azurerm_resource_group.internal_weu.name
      external       = azurerm_resource_group.external_weu.name
      sec            = azurerm_resource_group.sec_weu.name
      acr            = azurerm_resource_group.acr_weu.name
      assets_cdn     = azurerm_resource_group.assets_cdn_weu.name
      linux          = azurerm_resource_group.linux_weu.name
      operations     = azurerm_resource_group.operations_weu.name
    }
  }
}

output "azure_devops_agent" {
  value = {
    weu = module.azdoa_weu
    itn = null
  }
}
