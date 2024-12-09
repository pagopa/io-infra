## key vault

data "azurerm_key_vault_secret" "app_backend_API_KEY" {
  name         = "funcapp-KEY-APPBACKEND"
  key_vault_id = var.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_CGN_API_KEY" {
  name         = "funccgn-KEY-APPBACKEND"
  key_vault_id = var.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_IO_SIGN_API_KEY" {
  name         = "funciosign-KEY-APPBACKEND"
  key_vault_id = var.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_IO_FIMS_API_KEY" {
  name         = "funciofims-KEY-APPBACKEND"
  key_vault_id = var.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_CGN_OPERATOR_SEARCH_API_KEY_PROD" {
  name         = "funccgnoperatorsearch-KEY-PROD-APPBACKEND"
  key_vault_id = var.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_CGN_OPERATOR_SEARCH_API_KEY_UAT" {
  name         = "funccgnoperatorsearch-KEY-UAT-APPBACKEND"
  key_vault_id = var.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_PAGOPA_API_KEY_PROD" {
  name         = "appbackend-PAGOPA-API-KEY-PROD-PRIMARY"
  key_vault_id = var.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_PAGOPA_API_KEY_UAT" {
  name         = "appbackend-PAGOPA-API-KEY-UAT-PRIMARY"
  key_vault_id = var.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_ALLOW_MYPORTAL_IP_SOURCE_RANGE" {
  name         = "appbackend-ALLOW-MYPORTAL-IP-SOURCE-RANGE"
  key_vault_id = var.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_JWT_SUPPORT_TOKEN_PRIVATE_RSA_KEY" {
  name         = "appbackend-JWT-SUPPORT-TOKEN-PRIVATE-RSA-KEY"
  key_vault_id = var.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_TEST_CGN_FISCAL_CODES" {
  name         = "appbackend-TEST-CGN-FISCAL-CODES"
  key_vault_id = var.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_PECSERVER_TOKEN_SECRET" {
  name         = "appbackend-PECSERVER-TOKEN-SECRET"
  key_vault_id = var.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_PECSERVER_ARUBA_TOKEN_SECRET" {
  name         = "appbackend-PECSERVER-ARUBA-TOKEN-SECRET"
  key_vault_id = var.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_APP_MESSAGES_API_KEY" {
  count        = local.app_messages_count
  name         = count.index % local.app_messages_count == 0 ? "appbackend-APP-MESSAGES-API-KEY" : format("appbackend-APP-MESSAGES-API-KEY-%02d", (count.index % local.app_messages_count) + 1)
  key_vault_id = var.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_APP_CITIZEN_APIM_KEY" {
  name         = "appbackend-APP-CITIZEN-APIM-KEY"
  key_vault_id = var.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_APP_MESSAGES_BETA_FISCAL_CODES" {
  name         = "appbackend-APP-MESSAGES-BETA-FISCAL-CODES"
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

data "azurerm_key_vault_secret" "app_backend_PN_REAL_TEST_USERS" {
  name         = "appbackend-PN-REAL-TEST-USERS"
  key_vault_id = var.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_LOLLIPOP_ITN_API_KEY" {
  name         = "appbackend-LOLLIPOP-ITN-API-KEY"
  key_vault_id = var.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_UNIQUE_EMAIL_ENFORCEMENT_USER" {
  name         = "appbackend-UNIQUE-EMAIL-ENFORCEMENT-USER"
  key_vault_id = var.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_RECEIPT_SERVICE_TEST_API_KEY" {
  name         = "appbackend-RECEIPT-SERVICE-TEST-API-KEY"
  key_vault_id = var.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_RECEIPT_SERVICE_API_KEY" {
  name         = "appbackend-RECEIPT-SERVICE-API-KEY"
  key_vault_id = var.key_vault_common.id
}

data "azurerm_key_vault_secret" "fn_eucovidcert_API_KEY_APPBACKEND" {
  name         = "funceucovidcert-KEY-APPBACKEND"
  key_vault_id = var.key_vault_common.id
}

data "azurerm_key_vault_secret" "fn_eucovidcert_API_KEY_PUBLICIOEVENTDISPATCHER" {
  name         = "funceucovidcert-KEY-PUBLICIOEVENTDISPATCHER"
  key_vault_id = var.key_vault.id
}

data "azurerm_key_vault_secret" "app_backend_IO_WALLET_API_KEY" {
  name         = "funciowallet-KEY-APPBACKEND"
  key_vault_id = var.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_PRE_SHARED_KEY" {
  name         = "appbackend-PRE-SHARED-KEY"
  key_vault_id = var.key_vault_common.id
}
