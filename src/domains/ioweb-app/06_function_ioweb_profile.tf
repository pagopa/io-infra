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
      FAST_LOGIN_CLIENT_BASE_URL = "https://io-p-weu-fast-login-fn.azurewebsites.net"

      // -------------------------
      // Functions App config
      // -------------------------
      FUNCTIONS_APP_API_KEY         = data.azurerm_key_vault_secret.functions_app_api_key.value
      FUNCTIONS_APP_CLIENT_BASE_URL = "https://io-p-app-fn-2.azurewebsites.net"

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
    data.azurerm_subnet.function_app_snet[0].id,
    data.azurerm_subnet.function_app_snet[1].id,
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
    data.azurerm_subnet.function_app_snet[0].id,
    data.azurerm_subnet.function_app_snet[1].id,
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
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 3000
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "2"
        cooldown  = "PT5M"
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
        operator                 = "GreaterThan"
        threshold                = 45
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "2"
        cooldown  = "PT5M"
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
