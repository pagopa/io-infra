output "kv" {
  value = {
    id                  = azurerm_key_vault.kv.id
    name                = azurerm_key_vault.kv.name
    resource_group_name = azurerm_key_vault.kv.resource_group_name
  }
}

output "kv_common" {
  value = {
    id                  = azurerm_key_vault.common.id
    name                = azurerm_key_vault.common.name
    resource_group_name = azurerm_key_vault.common.resource_group_name
  }
}

output "io_p_itn_platform_kv_01" {
  value = {
    id                  = azurerm_key_vault.io_p_itn_platform_kv_01.id
    name                = azurerm_key_vault.io_p_itn_platform_kv_01.name
    resource_group_name = azurerm_key_vault.io_p_itn_platform_kv_01.resource_group_name
  }
}

output "tlscert_itn_01" {
  value = {
    id                  = azurerm_key_vault.tlscert_itn_01.id
    name                = azurerm_key_vault.tlscert_itn_01.name
    resource_group_name = azurerm_key_vault.tlscert_itn_01.resource_group_name
  }
}
