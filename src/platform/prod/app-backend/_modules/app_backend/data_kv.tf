data "azurerm_key_vault_secret" "app_backend_RECEIPT_SERVICE_TEST_API_KEY" {
  name         = "appbackend-RECEIPT-SERVICE-TEST-API-KEY"
  key_vault_id = var.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_RECEIPT_SERVICE_API_KEY" {
  name         = "appbackend-RECEIPT-SERVICE-API-KEY"
  key_vault_id = var.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_IO_SIGN_API_KEY" {
  name         = "funciosign-KEY-APPBACKEND"
  key_vault_id = var.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_PN_API_KEY_PROD" {
  name         = "appbackend-PN-API-KEY-PROD-ENV"
  key_vault_id = var.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_PN_API_KEY_UAT_V2" {
  name         = "appbackend-PN-API-KEY-UAT-ENV-V2"
  key_vault_id = var.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_UNIQUE_EMAIL_ENFORCEMENT_USER" {
  name         = "appbackend-UNIQUE-EMAIL-ENFORCEMENT-USER"
  key_vault_id = var.key_vault_common.id
}
