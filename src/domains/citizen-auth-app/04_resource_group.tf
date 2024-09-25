data "azurerm_resource_group" "rg_internal" {
  name = format("%s-rg-internal", local.product)
}

data "azurerm_resource_group" "rg_common" {
  name = format("%s-rg-common", local.product)
}

resource "azurerm_resource_group" "function_app_profile_rg" {
  count    = var.function_app_profile_count
  name     = format("%s-app-profile-rg-%d", local.common_project_itn, count.index + 1)
  location = local.itn_location

  tags = var.tags
}

resource "azurerm_resource_group" "function_app_profile_async_rg" {
  name     = format("%s-app-profile-async-rg", local.common_project_itn)
  location = local.itn_location

  tags = var.tags
}
