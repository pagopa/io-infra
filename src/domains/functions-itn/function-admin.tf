module "function_admin" {
  source = "git::https://github.com/pagopa/dx.git//infra/modules/azure_function_app?ref=DEVEX-153-gestire-la-definizione-dei-service-endpoints-nei-moduli-che-creano-delle-subnet"

  environment = {
    prefix          = var.prefix
    env_short       = local.env_short
    location        = local.location
    domain          = local.domain
    app_name        = "admin"
    instance_number = "01"
  }

  resource_group_name = local.resource_groups.regional.name
  health_check_path   = "/info"
  node_version        = 18

  subnet_cidr                          = local.function_admin.snet_cidr
  subnet_pep_id                        = data.azurerm_subnet.private_endpoints_subnet.id
  private_dns_zone_resource_group_name = local.resource_groups.common.name #data.azurerm_virtual_network.itn_common.resource_group_name # RG of vNET itn - VERIFY HOW TO SET (PRIVATE DNS DON'T EXIST NOW)

  virtual_network = {
    name                = local.virtual_networks.regional.name
    resource_group_name = local.resource_groups.regional.name
  }

  app_settings      = local.function_admin.app_settings
  slot_app_settings = local.function_admin.app_settings

  tier = local.function_admin.tier

  application_insights_connection_string = data.azurerm_application_insights.application_insights.connection_string

  tags = local.tags

  subnet_service_endpoints = {
    cosmos  = true
    web     = true
    storage = true
  }

}

resource "azurerm_monitor_metric_alert" "function_admin_health_check" {

  name                = "[${local.domain != null ? "${local.domain} | " : ""}${module.function_admin.function_app.function_app.name}] Health Check Failed"
  resource_group_name = module.function_admin.function_app.resource_group_name
  scopes              = [module.function_admin.function_app.function_app.id]
  description         = "Function availability is under threshold level. Runbook: -"
  severity            = 1
  frequency           = "PT5M"
  auto_mitigate       = false
  enabled             = true

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "HealthCheckStatus"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 50
  }

  dynamic "action" {
    for_each = local.function_admin.alert_action
    content {
      action_group_id    = action.value["action_group_id"]
      webhook_properties = action.value["webhook_properties"]
    }
  }
}