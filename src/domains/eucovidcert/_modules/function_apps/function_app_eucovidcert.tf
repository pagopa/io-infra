module "function_eucovidcert" {
  source = "github.com/pagopa/terraform-azurerm-v3//function_app?ref=v7.69.1"

  resource_group_name = var.resource_group_name
  name                = "${var.project}-eucovidcert-fn"
  location            = var.location
  health_check_path   = "/api/v1/info"

  node_version    = "14"
  runtime_version = "~4"

  always_on                                = "true"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_service_plan_info = {
    kind                         = "Linux"
    sku_size                     = "B1"
    maximum_elastic_worker_count = 0
    worker_count                 = null
    zone_balancing_enabled       = false
  }

  app_settings = merge(
    local.function_eucovidcert.app_settings,
    {
      "AzureWebJobs.NotifyNewProfileToDGC.Disabled" = "0"
    }
  )

  sticky_app_setting_names = [
    "AzureWebJobs.NotifyNewProfileToDGC.Disabled",
    "AzureWebJobs.OnProfileCreatedEvent.Disabled"
  ]

  subnet_id = var.subnet_id

  allowed_subnets = [
    var.subnet_id,
    data.azurerm_subnet.snet_backendl1.id,
    data.azurerm_subnet.snet_backendl2.id,
    data.azurerm_subnet.snet_apim_v2.id,
    data.azurerm_subnet.snet_backendl3.id,
    data.azurerm_subnet.apim_itn_snet.id
  ]

  tags = var.tags
}

