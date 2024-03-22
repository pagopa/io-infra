locals {
  resource_group_name_sec    = "${var.project}-sec-rg"
  resource_group_name_common = "${var.project}-rg-common"
  vnet_name_common           = "${var.project}-vnet-common"

  function_eucovidcert = {
    app_settings = {
      FUNCTIONS_WORKER_RUNTIME       = "node"
      WEBSITE_RUN_FROM_PACKAGE       = "1"
      WEBSITE_DNS_SERVER             = "168.63.129.16"
      FUNCTIONS_WORKER_PROCESS_COUNT = "4"
      NODE_ENV                       = "production"

      // Keepalive fields are all optionals
      FETCH_KEEPALIVE_ENABLED             = "true"
      FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
      FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
      FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
      FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
      FETCH_KEEPALIVE_TIMEOUT             = "60000"

      DGC_UAT_FISCAL_CODES = module.tests.test_users_eu_covid_cert_flat
      # we need test_users_store_review_flat because app IO reviewers must read a valid certificate response
      LOAD_TEST_FISCAL_CODES = join(",", [
        module.tests.test_users_store_review_flat,
        module.tests.test_users_internal_load_flat
      ])

      DGC_UAT_URL               = "https://servizi-pnval.dgc.gov.it"
      DGC_LOAD_TEST_URL         = "https://io-p-fn3-mockdgc.azurewebsites.net"
      DGC_PROD_URL              = "https://servizi-pn.dgc.gov.it"
      DGC_PROD_CLIENT_CERT      = trimspace(data.azurerm_key_vault_secret.fn_eucovidcert_DGC_PROD_CLIENT_CERT.value)
      DGC_PROD_CLIENT_KEY       = trimspace(data.azurerm_key_vault_secret.fn_eucovidcert_DGC_PROD_CLIENT_KEY.value)
      DGC_PROD_SERVER_CA        = trimspace(data.azurerm_key_vault_secret.fn_eucovidcert_DGC_PROD_SERVER_CA.value)
      DGC_UAT_CLIENT_CERT       = trimspace(data.azurerm_key_vault_secret.fn_eucovidcert_DGC_UAT_CLIENT_CERT.value)
      DGC_UAT_CLIENT_KEY        = trimspace(data.azurerm_key_vault_secret.fn_eucovidcert_DGC_UAT_CLIENT_KEY.value)
      DGC_UAT_SERVER_CA         = trimspace(data.azurerm_key_vault_secret.fn_eucovidcert_DGC_UAT_SERVER_CA.value)
      DGC_LOAD_TEST_CLIENT_KEY  = trimspace(data.azurerm_key_vault_secret.fn_eucovidcert_DGC_LOAD_TEST_CLIENT_KEY.value)
      DGC_LOAD_TEST_CLIENT_CERT = trimspace(data.azurerm_key_vault_secret.fn_eucovidcert_DGC_LOAD_TEST_CLIENT_CERT.value)
      DGC_LOAD_TEST_SERVER_CA   = trimspace(data.azurerm_key_vault_secret.fn_eucovidcert_DGC_LOAD_TEST_SERVER_CA.value)

      // Events configs
      EventsQueueStorageConnection                    = var.storage_account_eucovidcert_primary_connection_string
      EUCOVIDCERT_PROFILE_CREATED_QUEUE_NAME          = "eucovidcert-profile-created"
      QueueStorageConnection                          = var.storage_account_eucovidcert_primary_connection_string
      EUCOVIDCERT_NOTIFY_NEW_PROFILE_QUEUE_NAME       = "notify-new-profile"
      TableStorageConnection                          = var.storage_account_eucovidcert_primary_connection_string
      EUCOVIDCERT_TRACE_NOTIFY_NEW_PROFILE_TABLE_NAME = "TraceNotifyNewProfile"

      FNSERVICES_API_URL = join(",", formatlist("https://%s/api/v1", data.azurerm_linux_function_app.function_services.*.default_hostname))
      FNSERVICES_API_KEY = data.azurerm_key_vault_secret.fn_eucovidcert_FNSERVICES_API_KEY.value
    }
  }
}
