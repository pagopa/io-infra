data "azurerm_linux_function_app" "function_web_profile" {
  name                = format("%s-webprof-func-01", local.short_project_itn)
  resource_group_name = format("%s-webprof-rg-01", local.short_project_itn)
}