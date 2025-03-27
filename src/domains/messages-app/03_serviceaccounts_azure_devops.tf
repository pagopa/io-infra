#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "azure_devops_sa_token" {
  depends_on   = []
  name         = "${local.aks_name}-azure-devops-sa-token"
  value        = ""
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}

# #tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "azure_devops_sa_cacrt" {
  depends_on   = []
  name         = "${local.aks_name}-azure-devops-sa-cacrt"
  value        = ""
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}
