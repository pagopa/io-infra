data "azurerm_storage_account" "citizen_auth_common" {
  name                = replace(format("%s-weu-%s-st", local.product, var.domain), "-", "")
  resource_group_name = format("%s-%s-data-rg", local.product, var.domain)
}

data "azurerm_storage_account" "lollipop_assertion_storage" {
  name                = replace(format("%s-lollipop-assertions-st", local.product), "-", "")
  resource_group_name = format("%s-%s-data-rg", local.product, var.domain)
}

data "azurerm_storage_account" "logs" {
  name                = replace(format("%s-stlogs", local.product), "-", "")
  resource_group_name = format("%s-rg-operations", local.product)
}

data "azurerm_storage_account" "push_notifications_storage" {
  name                = replace(format("%s-com-st-01", local.common_project_itn), "-", "")
  resource_group_name = format("%s-com-rg-01", local.common_project_itn)
}

# Storages used by fn-profile
data "azurerm_storage_account" "storage_api" {
  name                = replace(format("%s-st-api", local.product), "-", "")
  resource_group_name = data.azurerm_resource_group.rg_internal.name
}

data "azurerm_storage_account" "assets_cdn" {
  name                = replace(format("%s-st-cdn-assets", local.product), "-", "")
  resource_group_name = data.azurerm_resource_group.rg_common.name
}

data "azurerm_storage_account" "notifications" {
  name                = replace(format("%s-st-notifications", local.product), "-", "")
  resource_group_name = data.azurerm_resource_group.rg_internal.name
}

data "azurerm_storage_account" "iopstapp" {
  name                = replace(format("%s-st-app", local.product), "-", "")
  resource_group_name = data.azurerm_resource_group.rg_internal.name
}

data "azurerm_storage_account" "storage_apievents" {
  name                = replace(format("%s-st-api-events", local.product), "-", "")
  resource_group_name = data.azurerm_resource_group.rg_internal.name
}
#################################
