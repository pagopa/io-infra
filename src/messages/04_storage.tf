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

resource "azurerm_storage_container" "services_storage_messages" {
  name                  = "messages"
  storage_account_name  = module.services_storage.name
  container_access_type = "private"
}

# TODO
# 1.abilitare la cancellazione dei blob dopo 1 giorno
# 2.abilitare i private endpoints

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "services_storage_connection_string" {
  name         = "${module.services_storage.name}-connection-string"
  value        = module.services_storage.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}
