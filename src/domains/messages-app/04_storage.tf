module "services_storage" {
  source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v2.7.0"

  name                       = replace(format("%s-svst", local.project), "-", "")
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

resource "azurerm_private_endpoint" "services_storage_blob" {
  name                = "${module.services_storage.name}-blob-endpoint"
  location            = var.location
  resource_group_name = azurerm_resource_group.data_process_rg.name
  subnet_id           = data.azurerm_subnet.private_endpoints_subnet.id

  private_service_connection {
    name                           = "${module.services_storage.name}-blob"
    private_connection_resource_id = module.services_storage.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_blob_core_windows_net.id]
  }

  tags = var.tags
}

resource "azurerm_storage_container" "services_storage_messages" {
  name                  = "messages"
  storage_account_name  = module.services_storage.name
  container_access_type = "private"
}

resource "azurerm_storage_management_policy" "services_storage" {
  storage_account_id = module.services_storage.id

  rule {
    name    = "deleteafterdays"
    enabled = true
    filters {
      prefix_match = ["messages"]
      blob_types   = ["blockBlob", "appendBlob"]
    }
    actions {
      base_blob {
        delete_after_days_since_modification_greater_than = 1
      }
      snapshot {
        delete_after_days_since_creation_greater_than = 1
      }
      version {
        delete_after_days_since_creation = 1
      }
    }
  }
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "services_storage_connection_string" {
  name         = "${module.services_storage.name}-connection-string"
  value        = module.services_storage.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}
