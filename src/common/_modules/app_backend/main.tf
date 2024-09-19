
resource "azurerm_resource_group" "rg_linux" {
  name     = format("%s-rg-linux", var.project)
  location = var.location

  tags = var.tags
}

module "appservice_app_backend" {
  source = "github.com/pagopa/terraform-azurerm-v3//app_service?ref=v8.31.0"

  # App service plan
  plan_type = "internal"
  plan_name = "${var.project}-plan-appappbackend${var.name}"
  sku_name  = var.plan_sku

  # App service
  name                = "${var.project}-app-appbackend${var.name}"
  resource_group_name = azurerm_resource_group.rg_linux.name
  location            = var.location

  node_version                 = "18-lts"
  always_on                    = true
  app_command_line             = local.app_command_line
  health_check_path            = "/ping"
  health_check_maxpingfailures = 2

  auto_heal_enabled = true
  auto_heal_settings = {
    startup_time           = "00:05:00"
    slow_requests_count    = 50
    slow_requests_interval = "00:01:00"
    slow_requests_time     = "00:00:10"
  }

  app_settings = merge(
    local.app_settings_common,
    var.app_settings_override
  )

  ip_restriction_default_action = "Deny"

  allowed_subnets = var.allowed_subnets
  
  allowed_ips = concat(
    [],
    var.application_insights.reserved_ips,
  )

  subnet_id        = azurerm_subnet.snet.id
  vnet_integration = true

  tags = var.tags
}

module "appservice_app_backend_slot_staging" {
  source = "github.com/pagopa/terraform-azurerm-v3//app_service_slot?ref=v8.31.0"

  # App service plan
  app_service_id   = module.appservice_app_backend.id
  app_service_name = module.appservice_app_backend.name

  # App service
  name                = "staging"
  resource_group_name = azurerm_resource_group.rg_linux.name
  location            = var.location

  always_on         = true
  node_version      = "18-lts"
  app_command_line  = local.app_command_line
  health_check_path = "/ping"

  auto_heal_enabled = true
  auto_heal_settings = {
    startup_time           = "00:05:00"
    slow_requests_count    = 50
    slow_requests_interval = "00:01:00"
    slow_requests_time     = "00:00:10"
  }

  app_settings = merge(
    local.app_settings_common,
    var.app_settings_override
  )

  ip_restriction_default_action = "Deny"

  allowed_subnets = concat(var.allowed_subnets, [var.azdoa_subnet.id])

  allowed_ips = concat(
    [],
  )

  subnet_id        = azurerm_subnet.snet.id
  vnet_integration = true

  tags = var.tags
}


## web availabolity test
module "app_backend_web_test_api" {
  source   = "github.com/pagopa/terraform-azurerm-v3//application_insights_web_test_preview?ref=v8.29.1"

  subscription_id                   = var.datasources.azurerm_client_config.subscription_id
  name                              = module.appservice_app_backend.default_site_hostname
  location                          = var.location
  resource_group                    = var.resource_groups.common
  request_url                       = "https://${module.appservice_app_backend.default_site_hostname}${local.webtest.path}"
  expected_http_status              = local.webtest.http_status
  ssl_cert_remaining_lifetime_check = 7
  application_insight_name          = var.application_insights.name
  application_insight_id            = var.application_insights.id

  actions = [
    {
      action_group_id = var.error_action_group_id
    }
  ]
}

# -----------------------------------------------
# Alerts
# -----------------------------------------------
resource "azurerm_monitor_metric_alert" "too_many_http_5xx" {
  enabled = false

  name                = "[IO-COMMONS | ${module.appservice_app_backend.name}] Too many 5xx"
  resource_group_name = azurerm_resource_group.rg_linux.name
  scopes              = [module.appservice_app_backend.id]
  # TODO: add Runbook for checking errors
  description   = "Whenever the total http server errors exceeds a dynamic threashold. Runbook: ${"https://pagopa.atlassian.net"}/wiki/spaces/IC/pages/585072814/Appbackendlx+-+Too+many+errors"
  severity      = 0
  window_size   = "PT5M"
  frequency     = "PT5M"
  auto_mitigate = false

  # Metric info
  # https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/metrics-supported#microsoftwebsites
  dynamic_criteria {
    metric_namespace         = "Microsoft.Web/sites"
    metric_name              = "Http5xx"
    aggregation              = "Total"
    operator                 = "GreaterThan"
    alert_sensitivity        = "Low"
    evaluation_total_count   = 4
    evaluation_failure_count = 4
    skip_metric_validation   = false

  }

  action {
    action_group_id    = var.error_action_group_id
    webhook_properties = null
  }

  tags = var.tags
}
