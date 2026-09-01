data "azurerm_key_vault_secret" "app_backend_UNIQUE_EMAIL_ENFORCEMENT_USER" {
  name         = "appbackend-UNIQUE-EMAIL-ENFORCEMENT-USER"
  key_vault_id = var.key_vault_common.id
}
