module "io_sign_storage" {
  source                                       = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v2.13.1"
  name                                         = replace(format("%s-st", local.project), "-", "")
  account_kind                                 = "StorageV2"
  account_tier                                 = "Standard"
  account_replication_type                     = var.storage.replication_type
  access_tier                                  = "Hot"
  enable_versioning                            = var.storage.enable_versioning
  versioning_name                              = "versioning"
  resource_group_name                          = azurerm_resource_group.data_rg.name
  location                                     = azurerm_resource_group.data_rg.location
  advanced_threat_protection                   = true
  allow_blob_public_access                     = false
  blob_properties_delete_retention_policy_days = var.storage.delete_retention_policy_days

  network_rules = {
    default_action = "Deny"
    ip_rules       = []
    bypass = [
      "Logging",
      "Metrics",
      "AzureServices",
    ]
    virtual_network_subnet_ids = [
      module.io_sign_snet.id,
      module.io_sign_user_snet.id,
    ]
  }

  tags = var.tags
}

resource "azurerm_storage_container" "uploaded_documents" {
  name                  = "uploaded-documents"
  storage_account_name  = module.io_sign_storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "validated_documents" {
  name                  = "validated-documents"
  storage_account_name  = module.io_sign_storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "signed_documents" {
  name                  = "signed-documents"
  storage_account_name  = module.io_sign_storage.name
  container_access_type = "private"
}

resource "azurerm_storage_queue" "waiting_message" {
  name                 = "waiting-message"
  storage_account_name = module.io_sign_storage.name
}
