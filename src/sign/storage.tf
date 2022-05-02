module "io_sign_storage" {
  source                                       = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v2.13.1"
  name                                         = replace("${local.project}-st", "-", "")
  account_kind                                 = "StorageV2"
  account_tier                                 = "Standard"
  account_replication_type                     = var.storage.replication_type
  access_tier                                  = "Hot"
  enable_versioning                            = var.storage.enable_versioning
  versioning_name                              = "versioning"
  resource_group_name                          = azurerm_resource_group.backend_rg.name
  location                                     = azurerm_resource_group.backend_rg.location
  advanced_threat_protection                   = true
  allow_blob_public_access                     = false
  blob_properties_delete_retention_policy_days = var.storage.delete_retention_policy_days
  tags                                         = var.tags
}