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

module "storage_account_elt_itn" {
  source = "github.com/pagopa/dx//infra/modules/azure_storage_account?ref=main"

  environment                          = local.itn_environment
  resource_group_name                  = var.resource_group_name_itn
  tier                                 = "l"
  subnet_pep_id                        = module.common_values.pep_subnets.itn.id
  private_dns_zone_resource_group_name = module.common_values.resource_groups.weu.common

  subservices_enabled = {
    blob  = true
    file  = false
    queue = false
    table = true
  }
  blob_features = {
    immutability_policy = {
      enabled = false
    }
    versioning = true
    change_feed = {
      enabled = true
    }
  }


  force_public_network_access_enabled = true

  tags = var.tags
}

resource "azurerm_storage_container" "messages_step_final_itn_new" {
  name                  = "messages-report-step-final"
  storage_account_name  = module.storage_account_elt_itn.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "messages_report_step1_itn_new" {
  name                  = "messages-report-step1"
  storage_account_name  = module.storage_account_elt_itn.name
  container_access_type = "private"
}

resource "azurerm_storage_table" "fnelterrors_itn_new" {
  name                 = "fnelterrors"
  storage_account_name = module.storage_account_elt_itn.name
}

resource "azurerm_storage_table" "fnelterrors_messages_itn_new" {
  name                 = "fnelterrorsMessages"
  storage_account_name = module.storage_account_elt_itn.name
}

resource "azurerm_storage_table" "fnelterrors_message_status_itn_new" {
  name                 = "fnelterrorsMessageStatus"
  storage_account_name = module.storage_account_elt_itn.name
}

resource "azurerm_storage_table" "fnelterrors_notification_status_itn_new" {
  name                 = "fnelterrorsNotificationStatus"
  storage_account_name = module.storage_account_elt_itn.name
}

resource "azurerm_storage_table" "fneltcommands_itn_new" {
  name                 = "fneltcommands"
  storage_account_name = module.storage_account_elt_itn.name
}

resource "azurerm_storage_table" "fneltexports_itn_new" {
  name                 = "fneltexports"
  storage_account_name = module.storage_account_elt_itn.name
}