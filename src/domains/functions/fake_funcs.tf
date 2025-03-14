resource "azurerm_linux_function_app" "this" {
  name                        = format("%s-admin-fn", local.project)
  resource_group_name         = azurerm_resource_group.admin_rg.name
  location                    = var.location
  functions_extension_version = "~4"
  service_plan_id             = module.function_admin.app_service_plan_id

  storage_account_name          = "iopadminfnst"
  storage_account_access_key    = ""
  https_only                    = true
  public_network_access_enabled = false

  site_config {
    minimum_tls_version               = "1.2"
    ftps_state                        = "Disabled"
    http2_enabled                     = true
    always_on                         = true
    pre_warmed_instance_count         = 1
    vnet_route_all_enabled            = true
    application_insights_key          = data.azurerm_application_insights.application_insights.instrumentation_key
    health_check_path                 = "/info"
    health_check_eviction_time_in_min = 2

    application_stack {
      node_version                = 20
    }
  }

  # https://docs.microsoft.com/en-us/azure/azure-functions/functions-app-settings
  app_settings = merge(
    {
      # No downtime on slots swap
      WEBSITE_ADD_SITENAME_BINDINGS_IN_APPHOST_CONFIG = 1
      # https://docs.microsoft.com/en-us/samples/azure-samples/azure-functions-private-endpoints/connect-to-private-endpoints-with-azure-functions/
      SLOT_TASK_HUBNAME        = "ProductionTaskHub"
      WEBSITE_RUN_FROM_PACKAGE = 1
      # https://docs.microsoft.com/en-us/azure/virtual-network/what-is-ip-address-168-63-129-16
      WEBSITE_DNS_SERVER = "168.63.129.16"
      # https://docs.microsoft.com/en-us/azure/azure-monitor/app/sampling
      APPINSIGHTS_SAMPLING_PERCENTAGE = 5
    },
  )

  lifecycle {
    ignore_changes = [
      virtual_network_subnet_id,
      app_settings["WEBSITE_HEALTHCHECK_MAXPINGFAILURES"],
      tags["hidden-link: /app-insights-conn-string"],
      tags["hidden-link: /app-insights-instrumentation-key"],
      tags["hidden-link: /app-insights-resource-id"]
    ]
  }

  tags = var.tags
}
