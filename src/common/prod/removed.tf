# This file will contain all the removed without destroy code blocks generated and used during the common domain split into multiple subdomains / platform
# https://pagopa.atlassian.net/browse/IOPLT-1626

removed {
  from = module.continua_app_service.azurerm_monitor_autoscale_setting.appservice_continua

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.continua_app_service.azurerm_resource_group.continua_itn_rg

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.continua_app_service.module.appservice_continua_itn.azurerm_linux_web_app_slot.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.continua_app_service.module.appservice_continua_itn.azurerm_linux_web_app.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.continua_app_service.module.appservice_continua_itn.azurerm_private_endpoint.app_service_sites

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.continua_app_service.module.appservice_continua_itn.azurerm_private_endpoint.staging_app_service_sites

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.continua_app_service.module.appservice_continua_itn.azurerm_service_plan.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.continua_app_service.module.appservice_continua_itn.azurerm_subnet.this

  lifecycle {
    destroy = false
  }
}
