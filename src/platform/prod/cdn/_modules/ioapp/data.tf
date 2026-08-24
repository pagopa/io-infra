data "azurerm_key_vault" "ioapp_it_kv" {
  name                = var.ioapp_apex_certificate_kv_name
  resource_group_name = var.ioapp_apex_certificate_kv_resource_group
}

data "azurerm_key_vault_certificate" "ioapp_it_certificate" {
  name         = var.ioapp_apex_certificate_name
  key_vault_id = data.azurerm_key_vault.ioapp_it_kv.id
}