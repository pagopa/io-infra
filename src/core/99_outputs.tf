output "sec_workspace_id" {
  value     = var.env_short == "p" ? data.azurerm_key_vault_secret.sec_workspace_id[0].value : null
  sensitive = true
}

output "sec_storage_id" {
  value     = var.env_short == "p" ? data.azurerm_key_vault_secret.sec_storage_id[0].value : null
  sensitive = true
}
