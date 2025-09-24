module "function_admin_storage_account" {
  source  = "pagopa-dx/azure-storage-account/azurerm"
  version = "~> 1.0"

  environment = {
    prefix          = var.prefix
    env_short       = var.env_short
    location        = var.location_itn
    app_name        = "funcadm"
    instance_number = "01"
  }
  resource_group_name = azurerm_resource_group.function_admin_itn_rg.name
  tier                = "l"
  subnet_pep_id       = data.azurerm_subnet.private_endpoints_subnet_itn.id

  subservices_enabled = {
    blob  = true
    queue = true
  }

  blob_features = {
    versioning = true
  }

  action_group_id = data.azurerm_monitor_action_group.error_action_group.id

  tags = var.tags
}

module "user_data_backups_storage_account" {
  source  = "pagopa-dx/azure-storage-account/azurerm"
  version = "~> 1.0"

  environment = {
    prefix          = var.prefix
    env_short       = var.env_short
    location        = var.location_itn
    app_name        = "userbackups"
    instance_number = "01"
  }
  resource_group_name = azurerm_resource_group.function_admin_itn_rg.name
  tier                = "l"
  subnet_pep_id       = data.azurerm_subnet.private_endpoints_subnet_itn.id

  subservices_enabled = {
    blob  = true
    queue = true
  }

  blob_features = {
    versioning = true
  }

  action_group_id = data.azurerm_monitor_action_group.error_action_group.id

  tags = var.tags
}

resource "azurerm_storage_container" "user-data-backup" {
  name               = "user-data-backup"
  storage_account_id = module.user_data_backups_storage_account.id
}

module "user_data_download_storage_account" {
  source  = "pagopa-dx/azure-storage-account/azurerm"
  version = "~> 1.0"

  environment = {
    prefix          = var.prefix
    env_short       = var.env_short
    location        = var.location_itn
    app_name        = "userdatadownload"
    instance_number = "01"
  }
  resource_group_name = azurerm_resource_group.function_admin_itn_rg.name
  tier                = "l"
  subnet_pep_id       = data.azurerm_subnet.private_endpoints_subnet_itn.id

  subservices_enabled = {
    blob  = true
    queue = true
  }

  blob_features = {
    versioning = true
  }

  action_group_id = data.azurerm_monitor_action_group.error_action_group.id

  tags = var.tags
}

resource "azurerm_storage_container" "user-data-download" {
  name               = "user-data-download"
  storage_account_id = module.user_data_download_storage_account.id
}
