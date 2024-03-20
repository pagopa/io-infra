#tfsec:ignore:azure-appservice-authentication-enabled:exp:2022-05-01 # already ignored, maybe a bug in tfsec
#tfsec:ignore:azure-appservice-require-client-cert:exp:2022-05-01 # already ignored, maybe a bug in tfsec
module "appservice_devportal_be" {
  source = "github.com/pagopa/terraform-azurerm-v3//app_service?ref=v7.69.1"

  name                = "${var.project}-app-devportal-be"
  resource_group_name = var.resource_group_name

  plan_type = "external"
  plan_id   = azurerm_service_plan.selfcare_be_common.id

  app_command_line = "node /home/site/wwwroot/build/src/app.js"
  node_version     = "14-lts"

  health_check_path = "/info"

  app_settings = local.app-devportal-be.app_settings

  allowed_subnets = [
    data.azurerm_subnet.snet_app_gw.id,
  ]

  tags = var.tags
}

# Only 1 subnet can be associated to a service plan
# azurerm_app_service_virtual_network_swift_connection requires an app service id
# so we choose one of the app service in the app service plan
resource "azurerm_app_service_virtual_network_swift_connection" "devportal_be" {
  app_service_id = module.appservice_devportal_be.id
  subnet_id      = var.subnet_id
}
