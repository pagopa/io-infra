resource "azurerm_monitor_scheduled_query_rules_alert" "eucovidcert_availability_getcertificate" {
  name                = format("[%s] %s %s", upper("eucovidcert"), "availability", "getcertificate")
  resource_group_name = azurerm_resource_group.rg_external.name
  location            = azurerm_resource_group.rg_external.location

  action {
    action_group = [azurerm_monitor_action_group.email.id, azurerm_monitor_action_group.slack.id]
  }

  data_source_id = data.azurerm_log_analytics_workspace.monitor_rg.id
  # todo when will send logs to sec workspace
  # data_source_id = var.env_short == "p" ? data.azurerm_key_vault_secret.sec_workspace_id[0].value : data.azurerm_log_analytics_workspace.monitor_rg.id
  description             = "Availability for Get Certificate is less than or equal to 99%, check ${module.app_gw.name}"
  enabled                 = var.eucovidcert_alerts_enabled
  auto_mitigation_enabled = true

  query = <<-QUERY
    AzureDiagnostics
    | where Resource == "IO-P-AG-APPGATEWAY" or Resource == "${upper(module.app_gw.name)}"
    | where host_s == "app-backend.io.italia.it"
    | where requestUri_s == "/api/v1/eucovidcert/certificate"
    | summarize
        Total=count(),
        Success=count(toint(httpStatus_d) == 200)
        by length=bin(timeStamp_t, 10m)
    | extend Availability=((Success * 1.0) / Total) * 100
    | where toreal(Availability) < 99.0
  QUERY

  severity    = 1
  frequency   = 10
  time_window = 20
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}
