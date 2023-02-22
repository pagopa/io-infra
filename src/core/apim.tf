# APIM subnet
module "apim_snet" {
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v4.1.15"
  name                 = "apimapi"
  resource_group_name  = azurerm_resource_group.rg_common.name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name
  address_prefixes     = var.cidr_subnet_apim

  private_endpoint_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.Web",
  ]
}


# ###########################
# ## Api Management (apim) ##
# ###########################

module "apim" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management?ref=v5.0.1"

  subnet_id                 = module.apim_snet.id
  location                  = azurerm_resource_group.rg_internal.location
  name                      = format("%s-apim-api", local.project)
  resource_group_name       = azurerm_resource_group.rg_internal.name
  publisher_name            = var.apim_publisher_name
  publisher_email           = data.azurerm_key_vault_secret.apim_publisher_email.value
  notification_sender_email = data.azurerm_key_vault_secret.apim_publisher_email.value
  sku_name                  = var.apim_sku
  virtual_network_type      = "Internal"

  # not used at the moment
  redis_connection_string = null # module.redis_apim.primary_connection_string
  redis_cache_id          = null # module.redis_apim.id

  # This enables the Username and Password Identity Provider
  sign_up_enabled = false

  hostname_configuration = {
    proxy = [
      {
        # io-p-apim-api.azure-api.net
        default_ssl_binding = false
        host_name           = "io-p-apim-api.azure-api.net"
        key_vault_id        = null
      },
      {
        # api-internal.io.italia.it
        default_ssl_binding = true
        host_name           = local.apim_hostname_api_internal
        key_vault_id = replace(
          data.azurerm_key_vault_certificate.api_internal_io_italia_it.secret_id,
          "/${data.azurerm_key_vault_certificate.api_internal_io_italia_it.version}",
          ""
        )
      },
      {
        # api-app.internal.io.pagopa.it
        default_ssl_binding = false
        host_name           = local.apim_hostname_api_app_internal
        key_vault_id = replace(
          data.azurerm_key_vault_certificate.api_app_internal_io_pagopa_it.secret_id,
          "/${data.azurerm_key_vault_certificate.api_app_internal_io_pagopa_it.version}",
          ""
        )
      },
    ]
    developer_portal = null
    management       = null
    portal           = null
  }

  application_insights = {
    enabled             = true
    instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key
  }

  lock_enable = false # no lock

  autoscale = var.apim_autoscale

  alerts_enabled = var.apim_alerts_enabled

  action = [
    {
      action_group_id    = azurerm_monitor_action_group.slack.id
      webhook_properties = null
    },
    {
      action_group_id    = azurerm_monitor_action_group.email.id
      webhook_properties = null
    }
  ]

  # metrics docs
  # https://docs.microsoft.com/en-us/azure/azure-monitor/essentials/metrics-supported#microsoftapimanagementservice
  metric_alerts = {
    capacity = {
      description   = "Apim used capacity is too high"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 1
      auto_mitigate = true

      criteria = [{
        metric_namespace       = "Microsoft.ApiManagement/service"
        metric_name            = "Capacity"
        aggregation            = "Average"
        operator               = "GreaterThan"
        threshold              = 40
        skip_metric_validation = false
        dimension              = []
      }]
      dynamic_criteria = []
    }

    duration = {
      description   = "Apim abnormal response time"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 2
      auto_mitigate = true

      criteria = []

      dynamic_criteria = [{
        metric_namespace         = "Microsoft.ApiManagement/service"
        metric_name              = "Duration"
        aggregation              = "Average"
        operator                 = "GreaterThan"
        alert_sensitivity        = "High"
        evaluation_total_count   = 2
        evaluation_failure_count = 2
        skip_metric_validation   = false
        ignore_data_before       = "2021-01-01T00:00:00Z" # sample data
        dimension                = []
      }]
    }

    requests_failed = {
      description   = "Apim abnormal failed requests"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 2
      auto_mitigate = true

      criteria = []

      dynamic_criteria = [{
        metric_namespace         = "Microsoft.ApiManagement/service"
        metric_name              = "Requests"
        aggregation              = "Total"
        operator                 = "GreaterThan"
        alert_sensitivity        = "High"
        evaluation_total_count   = 2
        evaluation_failure_count = 2
        skip_metric_validation   = false
        ignore_data_before       = "2021-01-01T00:00:00Z" # sample data
        dimension = [{
          name     = "BackendResponseCode"
          operator = "Include"
          values   = ["5xx"]
        }]
      }]
    }
  }

  tags = var.tags
}

data "azurerm_key_vault_secret" "apim_publisher_email" {
  name         = "apim-publisher-email"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_certificate" "api_internal_io_italia_it" {
  name         = replace(local.apim_hostname_api_internal, ".", "-")
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_certificate" "api_app_internal_io_pagopa_it" {
  name         = replace(local.apim_hostname_api_app_internal, ".", "-")
  key_vault_id = module.key_vault.id
}

# ## api management key vault policy ##
resource "azurerm_key_vault_access_policy" "apim_kv_policy" {
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.apim.principal_id

  key_permissions         = []
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
  storage_permissions     = []
}

resource "azurerm_key_vault_access_policy" "common" {
  key_vault_id = module.key_vault_common.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.apim.principal_id

  key_permissions         = []
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
  storage_permissions     = []
}
data "azurerm_key_vault_secret" "cgnonboardingportal_os_key" {
  name         = "funccgn-KEY-CGNOS"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "cgnonboardingportal_os_header_name" {
  name         = "funccgn-KEY-CGNOSHEADERNAME"
  key_vault_id = module.key_vault_common.id
}

resource "azurerm_api_management_named_value" "cgnonboardingportal_os_url_value" {
  name                = "cgnonboardingportal-os-url"
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_internal.name
  display_name        = "cgnonboardingportal-os-url"
  value               = format("https://cgnonboardingportal-%s-op.azurewebsites.net", var.env_short)
}

resource "azurerm_api_management_named_value" "cgnonboardingportal_os_key" {
  name                = "cgnonboardingportal-os-key"
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_internal.name
  display_name        = "cgnonboardingportal-os-key"
  value               = data.azurerm_key_vault_secret.cgnonboardingportal_os_key.value
  secret              = true
}

resource "azurerm_api_management_named_value" "cgnonboardingportal_os_header_name" {
  name                = "cgnonboardingportal-os-header-name"
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_internal.name
  display_name        = "cgnonboardingportal-os-header-name"
  value               = data.azurerm_key_vault_secret.cgnonboardingportal_os_header_name.value
  secret              = true
}

