module "io_sign_storage" {
  source                     = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v4.1.5"
  name                       = replace(format("%s-st", local.project), "-", "")
  account_kind               = "StorageV2"
  account_tier               = "Standard"
  account_replication_type   = var.storage.replication_type
  access_tier                = "Hot"
  enable_versioning          = var.storage.enable_versioning
  versioning_name            = "versioning"
  resource_group_name        = azurerm_resource_group.data_rg.name
  location                   = azurerm_resource_group.data_rg.location
  advanced_threat_protection = true
  allow_blob_public_access   = false

  network_rules = {
    default_action = "Allow"
    ip_rules       = []
    bypass = [
      "Logging",
      "Metrics",
      "AzureServices",
    ]
    virtual_network_subnet_ids = []
  }

  action = var.storage.enable_low_availability_alert ? [
    {
      action_group_id    = data.azurerm_monitor_action_group.email.id
      webhook_properties = {}
    },
    {
      action_group_id    = data.azurerm_monitor_action_group.slack.id
      webhook_properties = {}
    },
  ] : []

  tags = var.tags
}

resource "azurerm_storage_management_policy" "io_sign_storage_management_policy" {
  storage_account_id = module.io_sign_storage.id

  rule {
    name    = "deleteafterdays"
    enabled = true
    filters {
      prefix_match = [
        "uploaded-documents",
        "validated-documents",
        "signed-documents",
      ]
      blob_types = ["blockBlob"]
    }
    actions {
      base_blob {
        tier_to_cool_after_days_since_modification_greater_than    = 0
        tier_to_archive_after_days_since_modification_greater_than = 0
        delete_after_days_since_modification_greater_than          = var.storage.delete_after_days
      }
    }
  }
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

resource "azurerm_storage_container" "filled_modules" {
  name                  = "filled-modules"
  storage_account_name  = module.io_sign_storage.name
  container_access_type = "private"
}

resource "azurerm_storage_queue" "waiting_for_documents_to_fill" {
  name                 = "waiting-for-documents-to-fill"
  storage_account_name = module.io_sign_storage.name
}

resource "azurerm_storage_queue" "on_signature_request_ready" {
  name                 = "on-signature-request-ready"
  storage_account_name = module.io_sign_storage.name
}

resource "azurerm_storage_queue" "on_signature_request_wait_for_signature" {
  name                 = "on-signature-request-wait-for-signature"
  storage_account_name = module.io_sign_storage.name
}

resource "azurerm_storage_queue" "on_signature_request_rejected" {
  name                 = "on-signature-request-rejected"
  storage_account_name = module.io_sign_storage.name
}

resource "azurerm_storage_queue" "on_signature_request_signed" {
  name                 = "on-signature-request-signed"
  storage_account_name = module.io_sign_storage.name
}

resource "azurerm_storage_queue" "waiting_for_qtsp" {
  name                 = "waiting-for-qtsp"
  storage_account_name = module.io_sign_storage.name
}
