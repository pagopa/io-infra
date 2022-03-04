# KeyVault values - start
data "azurerm_key_vault_secret" "services_exclusion_list" {
  name         = "io-fn-services-SERVICEID-EXCLUSION-LIST"
  key_vault_id = data.azurerm_key_vault.common.id
}
