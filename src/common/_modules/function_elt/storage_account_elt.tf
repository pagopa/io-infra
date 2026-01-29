module "storage_account_itn_elt" {
  source  = "pagopa-dx/azure-storage-account/azurerm"
  version = "~> 2.0"

  environment = {
    prefix          = var.prefix
    env_short       = var.env_short
    location        = var.location_itn
    app_name        = "elt"
    instance_number = "02"
  }
  resource_group_name = azurerm_resource_group.itn_elt.name
  use_case            = "default"
  subnet_pep_id       = data.azurerm_subnet.private_endpoints_subnet_itn.id

  subservices_enabled = {
    blob  = true
    queue = true
    table = true
  }

  blob_features = {
    versioning = true
    change_feed = {
      enabled = true
    }
  }

  action_group_id = data.azurerm_monitor_action_group.error_action_group.id

  tags = var.tags
}

resource "azurerm_storage_container" "messages_step_final_itn" {
  name                  = "messages-report-step-final"
  storage_account_id    = module.storage_account_itn_elt.id
  container_access_type = "private"
}


resource "azurerm_storage_table" "fnelterrors_messages_itn" {
  name                 = "fnelterrorsMessages"
  storage_account_name = module.storage_account_itn_elt.name
}

resource "azurerm_storage_table" "fneltcommands_itn" {
  name                 = "fneltcommands"
  storage_account_name = module.storage_account_itn_elt.name
}



resource "azurerm_storage_table" "fneltexports_itn" {
  name                 = "fneltexports"
  storage_account_name = module.storage_account_itn_elt.name
}

resource "azurerm_storage_queue" "pdnd-io-cosmosdb-messages-failure" {
  name                 = "pdnd-io-cosmosdb-messages-failure"
  storage_account_name = module.storage_account_itn_elt.name
}

resource "azurerm_storage_queue" "pdnd-io-cosmosdb-messages-failure-poison" {
  name                 = "pdnd-io-cosmosdb-messages-failure-poison"
  storage_account_name = module.storage_account_itn_elt.name
}

resource "azurerm_storage_queue" "pdnd-io-cosmosdb-messagestatus-failure" {
  name                 = "pdnd-io-cosmosdb-messagestatus-failure"
  storage_account_name = module.storage_account_itn_elt.name
}

resource "azurerm_storage_queue" "pdnd-io-cosmosdb-messagestatus-failure-poison" {
  name                 = "pdnd-io-cosmosdb-messagestatus-failure-poison"
  storage_account_name = module.storage_account_itn_elt.name
}

resource "azurerm_storage_queue" "pdnd-io-cosmosdb-services-failure" {
  name                 = "pdnd-io-cosmosdb-services-failure"
  storage_account_name = module.storage_account_itn_elt.name
}

resource "azurerm_storage_queue" "pdnd-io-cosmosdb-services-failure-poison" {
  name                 = "pdnd-io-cosmosdb-services-failure-poison"
  storage_account_name = module.storage_account_itn_elt.name
}

resource "azurerm_storage_queue" "pdnd-io-cosmosdb-service-preferences-failure" {
  name                 = "pdnd-io-cosmosdb-service-preferences-failure"
  storage_account_name = module.storage_account_itn_elt.name
}

resource "azurerm_storage_queue" "pdnd-io-cosmosdb-service-preferences-failure-poison" {
  name                 = "pdnd-io-cosmosdb-service-preferences-failure-poison"
  storage_account_name = module.storage_account_itn_elt.name
}

resource "azurerm_storage_queue" "pdnd-io-cosmosdb-profiles-failure" {
  name                 = "pdnd-io-cosmosdb-profiles-failure"
  storage_account_name = module.storage_account_itn_elt.name
}

resource "azurerm_storage_queue" "pdnd-io-cosmosdb-profiles-failure-poison" {
  name                 = "pdnd-io-cosmosdb-profiles-failure-poison"
  storage_account_name = module.storage_account_itn_elt.name
}

resource "azurerm_storage_queue" "pdnd-io-cosmosdb-profile-deletion-failure" {
  name                 = "pdnd-io-cosmosdb-profile-deletion-failure"
  storage_account_name = module.storage_account_itn_elt.name
}

resource "azurerm_storage_queue" "pdnd-io-cosmosdb-profile-deletion-failure-poison" {
  name                 = "pdnd-io-cosmosdb-profile-deletion-failure-poison"
  storage_account_name = module.storage_account_itn_elt.name
}