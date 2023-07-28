data "azurerm_log_analytics_workspace" "io_law_common" {
  name                = var.io_common.log_analytics_workspace_name
  resource_group_name = var.io_common.resource_group_name
}

module "io_sign_container_app_environment" {
  source                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//container_app_environment?ref=v6.20.2"
  name                      = format("%-cae", local.project)
  location                  = azurerm_resource_group.backend_rg.location
  resource_group_name       = azurerm_resource_group.backend_rg.name
  log_destination           = "log-analytics"
  log_analytics_customer_id = azurerm_log_analytics_workspace.io_law_common.id
  log_analytics_shared_key  = azurerm_log_analytics_workspace.io_law_common.id
  subnet_id                 = module.io_sign_snet.id
  zone_redundant            = true
  tags                      = var.tags
}
