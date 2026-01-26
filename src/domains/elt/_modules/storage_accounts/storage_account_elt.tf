# Risorse migrate in altra infrastruttura - rimozione dallo state

removed {
  from = module.storage_account_itn_elt_02

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_storage_container.messages_step_final_itn_02

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_storage_container.messages_report_step1_itn_02

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_storage_table.fnelterrors_itn_02

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_storage_table.fnelterrors_messages_itn_02

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_storage_table.fnelterrors_message_status_itn_02

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_storage_table.fneltcommands_itn_02

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_storage_table.fneltexports_itn_02

  lifecycle {
    destroy = false
  }
}
