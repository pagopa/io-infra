data "azurerm_log_analytics_workspace" "io_law_common" {
  name                = var.io_common.log_analytics_workspace_name
  resource_group_name = var.io_common.resource_group_name
}

resource "azurerm_container_app_environment" "io_sign_cae" {
  name                       = format("%-cae", local.project)
  location                   = azurerm_resource_group.backend_rg.location
  resource_group_name        = azurerm_resource_group.backend_rg.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.io_law_common.id
  infrastructure_subnet_id   = module.io_sign_snet.id
  tags                       = var.tags
}
