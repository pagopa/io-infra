module "appservice_app_backend" {
  source = "github.com/pagopa/terraform-azurerm-v4//app_service?ref=fix/update-app-service-docker-tag" #v1.23.0"

  # App service plan
  plan_type = "internal"
  plan_name = try(local.nonstandard[var.location_short].asp, "${var.project}-appbe-${var.name}-asp-01")
  sku_name  = var.plan_sku

  # App service
  name                = try(local.nonstandard[var.location_short].app, "${var.project}-appbe-${var.name}-app-01")
  resource_group_name = var.resource_group_linux
  location            = var.location

  node_version                 = "20-lts"
  always_on                    = true
  app_command_line             = local.app_command_line
  health_check_path            = "/ping"
  health_check_maxpingfailures = 2

  auto_heal_enabled = var.is_li ? false : true # for li is disabled
  auto_heal_settings = var.is_li ? null : {
    startup_time           = "00:05:00"
    slow_requests_count    = 50
    slow_requests_interval = "00:01:00"
    slow_requests_time     = "00:00:10"
  }

  app_settings = merge(
    local.app_settings_common,
    var.app_settings_override
  )

  sticky_settings = concat(["APPINSIGHTS_CLOUD_ROLE_NAME", "APPINSIGHTS_SAMPLING_PERCENTAGE"])

  ip_restriction_default_action = "Deny"

  allowed_subnets = var.allowed_subnets

  allowed_ips = var.allowed_ips

  subnet_id        = azurerm_subnet.snet.id
  vnet_integration = true

  tags = var.tags
}

module "appservice_app_backend_slot_staging" {
  source = "github.com/pagopa/terraform-azurerm-v4//app_service_slot?ref=fix/update-app-service-docker-tag" #v1.23.0"

  # App service plan
  app_service_id   = module.appservice_app_backend.id
  app_service_name = module.appservice_app_backend.name

  # App service
  name                = "staging"
  resource_group_name = var.resource_group_linux
  location            = var.location

  always_on         = true
  node_version      = "20-lts"
  app_command_line  = local.app_command_line
  health_check_path = "/ping"

  auto_heal_enabled = var.is_li ? false : true # for li is disabled
  auto_heal_settings = var.is_li ? null : {
    startup_time           = "00:05:00"
    slow_requests_count    = 50
    slow_requests_interval = "00:01:00"
    slow_requests_time     = "00:00:10"
  }

  app_settings = merge(
    local.app_settings_common,
    var.app_settings_override,
    {
      "APPINSIGHTS_SAMPLING_PERCENTAGE" : 100,
      "APPINSIGHTS_CLOUD_ROLE_NAME" : "${local.nonstandard.weu.app}-staging"
    }
  )

  ip_restriction_default_action = "Deny"

  allowed_subnets = var.slot_allowed_subnets

  allowed_ips = var.slot_allowed_ips

  subnet_id        = azurerm_subnet.snet.id
  vnet_integration = true

  tags = var.tags
}
