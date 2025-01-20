removed {
  from = azurerm_resource_group.shared_rg_itn
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_app_service_plan.shared_plan_itn
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_monitor_autoscale_setting.function_public_itn
  lifecycle {
    destroy = false
  }
}
