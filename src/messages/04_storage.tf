module "services_storage" {
  source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v2.7.0"

  name                       = replace(format("%s-svcst", local.project), "-", "")
  account_kind               = "StorageV2"
  account_tier               = "Standard"
  access_tier                = "Hot"
  versioning_name            = "versioning"
  enable_versioning          = false
  account_replication_type   = "ZRS"
  resource_group_name        = azurerm_resource_group.data_process_rg.name
  location                   = var.location
  advanced_threat_protection = false
  allow_blob_public_access   = false

  tags = var.tags
}

# TODO
# 1.abilitare la cancellazione dei blob dopo 1 giorno
# 2.abilitare i private endpoints
