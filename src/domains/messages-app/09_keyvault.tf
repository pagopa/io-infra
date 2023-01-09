data "azurerm_key_vault" "common" {
  name                = format("%s-kv-common", local.product)
  resource_group_name = format("%s-rg-common", local.product)
}

data "azurerm_key_vault_secret" "azure_nh_endpoint" {
  name         = "common-AZURE-NH-ENDPOINT"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "azure_nh_partition1_endpoint" {
  name         = "common-partition-1-AZURE-NH-ENDPOINT"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "azure_nh_partition2_endpoint" {
  name         = "common-partition-2-AZURE-NH-ENDPOINT"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "azure_nh_partition3_endpoint" {
  name         = "common-partition-3-AZURE-NH-ENDPOINT"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "azure_nh_partition4_endpoint" {
  name         = "common-partition-4-AZURE-NH-ENDPOINT"
  key_vault_id = data.azurerm_key_vault.common.id
}
