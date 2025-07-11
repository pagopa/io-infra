data "azurerm_linux_function_app" "function_web_profile" {
  name                = format("%s-webprof-func-01", local.short_project_itn)
  resource_group_name = format("%s-webprof-rg-01", local.short_project_itn)
}

data "azurerm_linux_function_app" "function_lollipop_itn_v2" {
  name                = format("%s-lollipop-func-02", local.short_project_itn)
  resource_group_name = format("%s-lollipop-rg-02", local.short_project_itn)
}

data "azurerm_servicebus_namespace" "platform_service_bus_namespace" {
  name                = format("%s-platform-sbns-01", local.common_project_itn)
  resource_group_name = format("%s-common-rg-01", local.common_project_itn)
}
