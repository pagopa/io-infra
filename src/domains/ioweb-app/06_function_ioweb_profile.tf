###
### SECRETS
###
data "azurerm_key_vault_secret" "api_beta_testers" {
  name         = "ioweb-profile-api-beta-testers"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "functions_fast_login_api_key" {
  name         = "ioweb-profile-functions-fast-login-api-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "functions_app_api_key" {
  name         = "ioweb-profile-functions-app-api-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "spid_login_jwt_pub_key" {
  name         = "spid-login-jwt-pub-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "spid_login_api_key" {
  name         = "ioweb-profile-spid-login-api-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}
###

locals {
  function_JWT_issuer = "api-web.io.pagopa.it/ioweb/backend"
  function_ioweb_profile = {
    app_settings = {
      FUNCTIONS_WORKER_PROCESS_COUNT = 4
      NODE_ENV                       = "production"

      // Keepalive fields are all optionals
      FETCH_KEEPALIVE_ENABLED             = "true"
      FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
      FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
      FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
      FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
      FETCH_KEEPALIVE_TIMEOUT             = "60000"

      // --------------
      // FF AND TESTERS
      // --------------
      FF_API_ENABLED = "ALL"
      BETA_TESTERS   = data.azurerm_key_vault_secret.api_beta_testers.value

      // ------------
      // JWT Config
      // ------------
      BEARER_AUTH_HEADER               = "authorization"
      EXCHANGE_JWT_ISSUER              = local.function_JWT_issuer
      EXCHANGE_JWT_PRIMARY_PUB_KEY     = azurerm_key_vault_secret.exchange_jwt_pub_key.value
      EXCHANGE_JWT_PRIMARY_PRIVATE_KEY = azurerm_key_vault_secret.exchange_jwt_private_key.value
      // 1 hour
      EXCHANGE_JWT_TTL                   = "3600"
      MAGIC_LINK_JWE_PRIMARY_PRIVATE_KEY = azurerm_key_vault_secret.magic_link_jwe_private_key.value
      MAGIC_LINK_JWE_PRIMARY_PUB_KEY     = azurerm_key_vault_secret.magic_link_jwe_pub_key.value
      MAGIC_LINK_JWE_ISSUER              = local.function_JWT_issuer
      MAGIC_LINK_BASE_URL                = "https://ioapp.it/it/blocco-accesso/magic-link/"
      // TBD: more/less than 1 week?
      MAGIC_LINK_JWE_TTL = "604800"

      HUB_SPID_LOGIN_JWT_ISSUER  = "api-web.io.pagopa.it/ioweb/auth"
      HUB_SPID_LOGIN_JWT_PUB_KEY = data.azurerm_key_vault_secret.spid_login_jwt_pub_key.value

      // -------------------------
      // Fast Login config
      // -------------------------
      FAST_LOGIN_API_KEY         = data.azurerm_key_vault_secret.functions_fast_login_api_key.value
      FAST_LOGIN_CLIENT_BASE_URL = "https://io-p-itn-auth-lv-func-02.azurewebsites.net"

      // -------------------------
      // Functions App config
      // -------------------------
      FUNCTIONS_APP_API_KEY         = data.azurerm_key_vault_secret.functions_app_api_key.value
      FUNCTIONS_APP_CLIENT_BASE_URL = "https://io-p-itn-auth-profile-fn-02.azurewebsites.net"

      // -------------------------
      // Hub Spid Login for ioweb config
      // -------------------------
      HUB_SPID_LOGIN_API_KEY         = data.azurerm_key_vault_secret.spid_login_api_key.value
      HUB_SPID_LOGIN_CLIENT_BASE_URL = "https://io-p-weu-ioweb-spid-login.azurewebsites.net"

      // -------------------------
      // Audit Logs config
      // -------------------------
      AUDIT_LOG_CONNECTION_STRING = data.azurerm_storage_account.immutable_spid_logs_storage.primary_connection_string
      AUDIT_LOG_CONTAINER         = data.azurerm_storage_container.immutable_audit_logs.name

      // -------------------------
      // Teamporary Blacklist Magic Link
      // -------------------------
      BLACKLISTED_JTI_LIST = "3f1b9570-737f-49b3-a080-51c4cefd70bd,723cd0d4-00a8-4b01-bc8a-2aa9fd4cae23,7abf3c2d-14a7-46d5-8ea1-b00119db01f3,ac2ca815-a0bb-4eb0-b0b7-52de63647298,bf290003-e38d-4ce8-8311-fd7bef83bda7,bef6318b-fdbf-4f07-bfd9-72a807cba89e,1f8f672f-ca05-4b05-a88b-b2e87758f4be,09df907a-86af-4349-9262-704d978c6efc,29987a32-2447-4112-acf9-88b6aff6706a,5082b579-cc7f-4808-8707-0e2b806f03b5,19b28bea-397a-4ab1-905f-f1666492626a,5b980b81-6351-46b0-b6c0-660f668415d5,61613cfa-7ec9-469e-93c9-b00c3767d102,6e18006b-146a-4256-8d9e-a625cd6b05c5,4d315150-cf19-4196-839f-7b5a3ca57bf2,45d5ed31-cade-4a29-a566-95333e692952,00e2a3df-69df-4e2d-9bc8-8be5807cf196,c9c5ddf2-97cd-4d2a-b9c5-0c7fd1658c14,4d4833c3-5f31-4db2-9722-726e1e5840c6,de1d7479-6cb7-48df-88e0-4bdffd6e6d4e,8664225d-67a4-47b3-b708-1c12b8e00dd0,59a0811d-7621-47bb-bfae-6d4aecaa1a73,09d93bd3-416b-48b2-af5f-ed67bf22e4f7,461a93fe-5497-4d0b-9320-6b941b22f6f2,e78676b7-96d9-4404-8841-c7be646e5d68,8a94f472-2e49-4fcd-9125-8b343c94901b,9feb3ad9-015b-4caf-912b-5f232a0d1456,a9610106-fa03-4829-96c2-04dbe0147953,c7529004-b6a1-42fb-85a6-d6e6eccde42d,cd03cabd-63a5-42e0-815c-10d23dda1583,e0731a53-4bbe-4bff-9be9-ea367b448b79,055c1679-7fea-40f2-a48f-184e21981888,e42297f9-f5df-4bce-98a5-c7b13c7aaff1,7bf9959e-b43f-4952-aae5-ca956e3a7edd,090eefd0-1fa7-4a39-9ba2-46c5668eeac4,901e49ca-ef22-4f9f-a315-c44ad4971a75,eca6aeda-fb73-4820-a962-64c652dad4fc,795a9b5f-0d60-4135-ac4b-fbddb96c850b,46539598-077e-4ebd-80b3-618f28b50c98,32bc4424-9587-4c6a-9fe2-b8c8d73c0742,b12add73-44ab-4c4a-8257-72d14d31331a,12aceef9-ee3c-4b0f-955a-c356c64f2d74,4ec72810-39b6-4db3-9106-0bb6c0d6db3d,cbca089e-3c1d-4376-a49a-ad6f4b2b8060,7e2b0afd-fa12-4ff0-892a-e4b437b108e8,558f4a85-0d05-4028-8e27-6fc82dcf6924,bdce1a81-5938-414f-a25c-8733fe39b136,7f665313-69da-4fc2-93a1-3e67ba7f9304,42b79b72-ac33-4ff5-9e22-2141be837ff3,b70c54cc-ee2c-4d2a-8252-f57a115c5272,4e6792d2-6de2-4eea-9743-b55e3e0c2828,1530b5b3-489c-4969-ba69-454ba85305c4,7c0c1458-87ea-4109-b6e1-5a06be52be43,f54da8e7-01d8-4e39-83bd-aff726309320"
    }
  }
}


# Subnet to host admin function
module "ioweb_profile_snet" {
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v4.1.15"
  name                                      = format("%s-ioweb-profile-snet", local.common_project)
  address_prefixes                          = var.cidr_subnet_fniowebprofile
  resource_group_name                       = data.azurerm_virtual_network.vnet_common.resource_group_name
  virtual_network_name                      = data.azurerm_virtual_network.vnet_common.name
  private_endpoint_network_policies_enabled = false

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.Storage",
  ]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

module "function_ioweb_profile" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app?ref=v5.2.0"

  resource_group_name = azurerm_resource_group.ioweb_profile_rg.name
  name                = format("%s-ioweb-profile-fn", local.common_project)
  location            = var.location
  domain              = "IO-AUTH"
  health_check_path   = "/api/v1/info"

  node_version    = "18"
  runtime_version = "~4"

  always_on                                = "true"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_service_plan_info = {
    kind                         = var.function_ioweb_profile.kind
    sku_size                     = var.function_ioweb_profile.sku_size
    maximum_elastic_worker_count = 0
  }

  app_settings = merge(
    local.function_ioweb_profile.app_settings,
  )

  internal_storage = {
    "enable"                     = true,
    "private_endpoint_subnet_id" = data.azurerm_subnet.private_endpoints_subnet.id,
    "private_dns_zone_blob_ids"  = [data.azurerm_private_dns_zone.privatelink_blob_core_windows_net.id],
    "private_dns_zone_queue_ids" = [data.azurerm_private_dns_zone.privatelink_queue_core_windows_net.id],
    "private_dns_zone_table_ids" = [data.azurerm_private_dns_zone.privatelink_table_core_windows_net.id],
    "queues"                     = [],
    "containers"                 = [],
    "blobs_retention_days"       = 0,
  }

  subnet_id = module.ioweb_profile_snet.id

  allowed_subnets = [
    module.ioweb_profile_snet.id,
    data.azurerm_subnet.apim_v2_snet.id,
    data.azurerm_subnet.function_profile_snet[0].id,
    data.azurerm_subnet.function_profile_snet[1].id,
  ]

  enable_healthcheck = false

  # Action groups for alerts
  action = [
    {
      action_group_id    = data.azurerm_monitor_action_group.error_action_group.id
      webhook_properties = {}
    }
  ]

  tags = var.tags
}

module "function_ioweb_profile_staging_slot" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app_slot?ref=v5.2.0"

  name                = "staging"
  location            = var.location
  resource_group_name = azurerm_resource_group.ioweb_profile_rg.name
  function_app_id     = module.function_ioweb_profile.id
  app_service_plan_id = module.function_ioweb_profile.app_service_plan_id
  health_check_path   = "/api/v1/info"

  storage_account_name               = module.function_ioweb_profile.storage_account.name
  storage_account_access_key         = module.function_ioweb_profile.storage_account.primary_access_key
  internal_storage_connection_string = module.function_ioweb_profile.storage_account_internal_function.primary_connection_string

  node_version                             = "18"
  always_on                                = "true"
  runtime_version                          = "~4"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_settings = merge(
    local.function_ioweb_profile.app_settings,
  )

  subnet_id = module.ioweb_profile_snet.id

  allowed_subnets = [
    module.ioweb_profile_snet.id,
    data.azurerm_subnet.azdoa_snet[0].id,
    data.azurerm_subnet.apim_v2_snet.id,
    data.azurerm_subnet.function_profile_snet[0].id,
    data.azurerm_subnet.function_profile_snet[1].id,
  ]

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "function_ioweb_profile" {
  name                = format("%s-autoscale", module.function_ioweb_profile.name)
  resource_group_name = azurerm_resource_group.ioweb_profile_rg.name
  location            = var.location
  target_resource_id  = module.function_ioweb_profile.app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = var.function_ioweb_profile.autoscale_default
      minimum = var.function_ioweb_profile.autoscale_minimum
      maximum = var.function_ioweb_profile.autoscale_maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.function_ioweb_profile.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT1M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 3000
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "2"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "CpuPercentage"
        metric_resource_id       = module.function_ioweb_profile.app_service_plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT1M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 45
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "2"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.function_ioweb_profile.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 2000
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT20M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "CpuPercentage"
        metric_resource_id       = module.function_ioweb_profile.app_service_plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 30
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT20M"
      }
    }
  }
}

// ----------------------------------------------------
// Alerts
// ----------------------------------------------------
resource "azurerm_monitor_scheduled_query_rules_alert_v2" "alert_too_much_invalid_codes_on_unlock" {
  enabled                 = true
  name                    = "[${upper(var.domain)} | ${module.function_ioweb_profile.name}] Unexpected number of invalid codes to unlock endpoint"
  resource_group_name     = azurerm_resource_group.ioweb_profile_rg.name
  scopes                  = [data.azurerm_application_gateway.app_gateway.id]
  description             = "Too many invalid codes submitted to IO-WEB profile unlock functionality"
  severity                = 1
  auto_mitigation_enabled = false
  location                = azurerm_resource_group.ioweb_profile_rg.location

  // check once every minute(evaluation_frequency)
  // on the last minute of data(window_duration)
  evaluation_frequency = "PT1M"
  window_duration      = "PT1M"

  criteria {
    query                   = <<-QUERY
AzureDiagnostics
| where requestUri_s == "/ioweb/backend/api/v1/unlock-session" and httpMethod_s == "POST"
| where serverStatus_s == 403
    QUERY
    operator                = "GreaterThanOrEqual"
    time_aggregation_method = "Count"
    threshold               = 5
    failing_periods {
      minimum_failing_periods_to_trigger_alert = 1
      number_of_evaluation_periods             = 1
    }
  }

  # Action groups for alerts
  action {
    action_groups = [data.azurerm_monitor_action_group.error_action_group.id]
  }

  tags = var.tags
}


resource "azurerm_monitor_scheduled_query_rules_alert_v2" "alert_too_much_calls_on_unlock" {
  enabled                 = true
  name                    = "[${upper(var.domain)} | ${module.function_ioweb_profile.name}] Unexpected number of calls to unlock endpoint"
  resource_group_name     = azurerm_resource_group.ioweb_profile_rg.name
  scopes                  = [data.azurerm_application_gateway.app_gateway.id]
  description             = "Too many calls submitted to IO-WEB profile unlock functionality"
  severity                = 1
  auto_mitigation_enabled = false
  location                = azurerm_resource_group.ioweb_profile_rg.location

  // check once every minute(evaluation_frequency)
  // on the last minute of data(window_duration)
  evaluation_frequency = "PT1M"
  window_duration      = "PT1M"

  criteria {
    query                   = <<-QUERY
AzureDiagnostics
| where requestUri_s == "/ioweb/backend/api/v1/unlock-session" and httpMethod_s == "POST"
| where serverStatus_s == 429
    QUERY
    operator                = "GreaterThanOrEqual"
    time_aggregation_method = "Count"
    threshold               = 1
    failing_periods {
      minimum_failing_periods_to_trigger_alert = 1
      number_of_evaluation_periods             = 1
    }
  }

  # Action groups for alerts
  action {
    action_groups = [data.azurerm_monitor_action_group.error_action_group.id]
  }

  tags = var.tags
}
