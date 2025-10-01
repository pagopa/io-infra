module "function_admin_storage_account" {
  source  = "pagopa-dx/azure-storage-account/azurerm"
  version = "~> 2.0"

  environment = {
    prefix          = var.prefix
    env_short       = var.env_short
    location        = var.location_itn
    app_name        = "funcadm"
    instance_number = "01"
  }
  resource_group_name = azurerm_resource_group.function_admin_itn_rg.name
  use_case            = "default"
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
  version = "~> 2.0"

  environment = {
    prefix          = var.prefix
    env_short       = var.env_short
    location        = var.location_itn
    app_name        = "userbackups"
    instance_number = "01"
  }
  resource_group_name = azurerm_resource_group.function_admin_itn_rg.name
  use_case            = "audit"
  subnet_pep_id       = data.azurerm_subnet.private_endpoints_subnet_itn.id

  subservices_enabled = {
    blob  = true
    queue = true
  }

  containers = [{
    name        = "user-data-backup"
    access_type = "private"
  }]

  customer_managed_key = {
    enabled      = true
    type         = "kv"
    key_vault_id = data.azurerm_key_vault.common.id
  }

  blob_features = {
    versioning = true
  }

  action_group_id = data.azurerm_monitor_action_group.error_action_group.id

  tags = var.tags
}

module "user_data_download_storage_account" {
  source  = "pagopa-dx/azure-storage-account/azurerm"
  version = "~> 2.0"

  environment = {
    prefix          = var.prefix
    env_short       = var.env_short
    location        = var.location_itn
    app_name        = "usrdatadwnld"
    instance_number = "01"
  }
  resource_group_name = azurerm_resource_group.function_admin_itn_rg.name
  use_case            = "default"
  subnet_pep_id       = data.azurerm_subnet.private_endpoints_subnet_itn.id

  subservices_enabled = {
    blob  = true
    queue = true
  }

  containers = [{
    name        = "user-data-download"
    access_type = "private"
  }]

  blob_features = {
    versioning = true
  }

  action_group_id = data.azurerm_monitor_action_group.error_action_group.id

  tags = var.tags
}

resource "azurerm_storage_management_policy" "user_data_download_container_rule" {
  storage_account_id = module.user_data_download_storage_account.id

  rule {
    name    = "deleteafter14days"
    enabled = true
    filters {
      prefix_match = ["user-data-download"]
      blob_types   = ["blockBlob"]
    }
    actions {
      base_blob {
        delete_after_days_since_creation_greater_than = 14
      }
      snapshot {
        delete_after_days_since_creation_greater_than = 14
      }
      version {
        delete_after_days_since_creation = 14
      }
    }
  }
}