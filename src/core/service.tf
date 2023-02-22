# TODO: To remove, this function han been removed
resource "azurerm_monitor_scheduled_query_rules_alert" "service_availability_manageservices" {
  name                = format("[%s | %s] %s", upper("service"), "io-p-services-fn", "Service Availability below the threshold")
  resource_group_name = azurerm_resource_group.rg_external.name
  location            = azurerm_resource_group.rg_external.location

  action {
    action_group = [azurerm_monitor_action_group.quarantine_error_action_group.id]
  }

  data_source_id          = data.azurerm_log_analytics_workspace.monitor_rg.id
  description             = "Availability for get and manage services is less than or equal to ${var.service_availability_alerts_threshold}%."
  enabled                 = var.service_alerts_enabled
  auto_mitigation_enabled = true

  query = <<-QUERY
    AzureDiagnostics
    | where Resource == "${upper(module.app_gw.name)}"
    | where originalHost_s in ("api.io.italia.it" , "api.io.pagopa.it", "api-mtls.io.pagopa.it")
    | where requestUri_s startswith "/api/v1/services"
    | where httpStatus_d in (200, 201, 304, 400, 401, 403, 404, 429)
    | summarize n_success = toreal(count()) by bin(TimeGenerated, 10m)
    | join kind=inner (
      AzureDiagnostics
      | where Resource == "${upper(module.app_gw.name)}"
      | where originalHost_s in ("api.io.italia.it" , "api.io.pagopa.it", "api-mtls.io.pagopa.it")
      | where requestUri_s startswith "/api/v1/services"
      | summarize n_total = toreal(count()) by bin(TimeGenerated, 10m))
    on TimeGenerated
    | project TimeGenerated, availability=(n_success/n_total)*100
    | where toreal(availability) < ${var.service_availability_alerts_threshold}
  QUERY

  severity    = 1
  frequency   = 10
  time_window = 20
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}
