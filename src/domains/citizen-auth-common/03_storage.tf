locals {
  lv_storage_immutability_policy_days = 730
}

###
# LolliPoP Assertion Storage
###
module "lollipop_assertions_storage" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//storage_account?ref=v6.1.0"

  name                          = replace(format("%s-lollipop-assertions-st", local.product), "-", "") # `lollipop-assertions-st` is used in src/core/99_variables.tf#citizen_auth_assertion_storage_name
  domain                        = upper(var.domain)
  account_kind                  = "StorageV2"
  account_tier                  = "Standard"
  access_tier                   = "Hot"
  account_replication_type      = "GZRS"
  resource_group_name           = azurerm_resource_group.data_rg.name
  location                      = var.location
  advanced_threat_protection    = true
  enable_identity               = true
  public_network_access_enabled = false

  tags = var.tags
}

module "lollipop_assertions_storage_customer_managed_key" {
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3//storage_account_customer_managed_key?ref=v4.3.1"
  tenant_id            = data.azurerm_subscription.current.tenant_id
  location             = var.location
  resource_group_name  = azurerm_resource_group.data_rg.name
  key_vault_id         = module.key_vault.id
  key_name             = format("%s-key", module.lollipop_assertions_storage.name)
  storage_id           = module.lollipop_assertions_storage.id
  storage_principal_id = module.lollipop_assertions_storage.identity.0.principal_id
}

resource "azurerm_private_endpoint" "lollipop_assertion_storage_blob" {
  name                = "${module.lollipop_assertions_storage.name}-blob-endpoint"
  location            = var.location
  resource_group_name = azurerm_resource_group.data_rg.name
  subnet_id           = data.azurerm_subnet.private_endpoints_subnet.id

  private_service_connection {
    name                           = "${module.lollipop_assertions_storage.name}-blob"
    private_connection_resource_id = module.lollipop_assertions_storage.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_blob_core_windows_net.id]
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "lollipop_assertion_storage_queue" {
  name                = "${module.lollipop_assertions_storage.name}-queue-endpoint"
  location            = var.location
  resource_group_name = azurerm_resource_group.data_rg.name
  subnet_id           = data.azurerm_subnet.private_endpoints_subnet.id

  private_service_connection {
    name                           = "${module.lollipop_assertions_storage.name}-queue"
    private_connection_resource_id = module.lollipop_assertions_storage.id
    is_manual_connection           = false
    subresource_names              = ["queue"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_queue_core_windows_net.id]
  }

  tags = var.tags
}

resource "azurerm_storage_container" "lollipop_assertions_storage_assertions" {
  name                  = "assertions"
  storage_account_name  = module.lollipop_assertions_storage.name
  container_access_type = "private"
}

resource "azurerm_storage_queue" "lollipop_assertions_storage_revoke_queue" {
  name                 = "pubkeys-revoke" # This value is used in src/core/99_variables.tf#citizen_auth_revoke_queue_name
  storage_account_name = module.lollipop_assertions_storage.name
}



###
# Immutable LV Audit Log Storage
###
module "immutable_lv_audit_logs_storage" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//storage_account?ref=v7.32.1"

  name                          = replace(format("%s-lv-logs-im-st", local.product), "-", "")
  domain                        = upper(var.domain)
  account_kind                  = "StorageV2"
  account_tier                  = "Standard"
  access_tier                   = "Hot"
  account_replication_type      = "GZRS"
  resource_group_name           = azurerm_resource_group.data_rg.name
  location                      = var.location
  advanced_threat_protection    = true
  use_legacy_defender_version   = false
  enable_identity               = true
  public_network_access_enabled = false

  # Needed for immtability policy
  blob_versioning_enabled = true

  blob_storage_policy = {
    enable_immutability_policy = true
    blob_restore_policy_days   = 0
  }
  immutability_policy_props = {
    allow_protected_append_writes = false
    period_since_creation_in_days = local.lv_storage_immutability_policy_days
  }

  tags = var.tags
}

module "immutable_lv_audit_logs_storage_customer_managed_key" {
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3//storage_account_customer_managed_key?ref=v7.32.1"
  tenant_id            = data.azurerm_subscription.current.tenant_id
  location             = var.location
  resource_group_name  = azurerm_resource_group.data_rg.name
  key_vault_id         = module.key_vault.id
  key_name             = format("%s-key", module.immutable_lv_audit_logs_storage.name)
  storage_id           = module.immutable_lv_audit_logs_storage.id
  storage_principal_id = module.immutable_lv_audit_logs_storage.identity.0.principal_id
}

resource "azurerm_private_endpoint" "immutable_lv_audit_logs_storage_blob" {
  depends_on = [module.immutable_lv_audit_logs_storage]

  name                = "${module.immutable_lv_audit_logs_storage.name}-blob-endpoint"
  location            = var.location
  resource_group_name = azurerm_resource_group.data_rg.name
  subnet_id           = data.azurerm_subnet.private_endpoints_subnet.id

  private_service_connection {
    name                           = "${module.immutable_lv_audit_logs_storage.name}-blob"
    private_connection_resource_id = module.immutable_lv_audit_logs_storage.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_blob_core_windows_net.id]
  }

  tags = var.tags
}

# Containers
resource "azurerm_storage_container" "immutable_lv_audit_logs_storage_logs" {
  depends_on = [module.immutable_lv_audit_logs_storage, azurerm_private_endpoint.immutable_lv_audit_logs_storage_blob]

  name                  = "logs"
  storage_account_name  = module.immutable_lv_audit_logs_storage.name
  container_access_type = "private"
}

# Policies
resource "azurerm_storage_management_policy" "immutable_lv_audit_logs_storage_management_policy" {
  depends_on = [module.immutable_lv_audit_logs_storage, azurerm_storage_container.immutable_lv_audit_logs_storage_logs]

  storage_account_id = module.immutable_lv_audit_logs_storage.id

  rule {
    name    = "deleteafter2yrs"
    enabled = true
    filters {
      prefix_match = [
        azurerm_storage_container.immutable_lv_audit_logs_storage_logs.name,
      ]
      blob_types = ["blockBlob"]
    }
    actions {
      base_blob {
        delete_after_days_since_creation_greater_than = local.lv_storage_immutability_policy_days + 1
      }
      snapshot {
        delete_after_days_since_creation_greater_than = local.lv_storage_immutability_policy_days + 1
      }
      version {
        delete_after_days_since_creation = local.lv_storage_immutability_policy_days + 1
      }
    }
  }
}


###
# Citizen Auth Storage
###
module "io_citizen_auth_storage" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//storage_account?ref=v6.1.0"

  name                          = replace(format("%s-st", local.project), "-", "")
  domain                        = upper(var.domain)
  account_kind                  = "StorageV2"
  account_tier                  = "Standard"
  access_tier                   = "Hot"
  account_replication_type      = "GZRS"
  resource_group_name           = azurerm_resource_group.data_rg.name
  location                      = var.location
  advanced_threat_protection    = true
  enable_identity               = true
  public_network_access_enabled = false

  tags = var.tags
}

resource "azurerm_private_endpoint" "table" {
  depends_on          = [module.io_citizen_auth_storage]
  name                = format("%s-table-endpoint", module.io_citizen_auth_storage.name)
  location            = var.location
  resource_group_name = azurerm_resource_group.data_rg.name
  subnet_id           = data.azurerm_subnet.private_endpoints_subnet.id

  private_service_connection {
    name                           = format("%s-table", module.io_citizen_auth_storage.name)
    private_connection_resource_id = module.io_citizen_auth_storage.id
    is_manual_connection           = false
    subresource_names              = ["table"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_table_core.id]
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "queue" {
  depends_on          = [module.io_citizen_auth_storage]
  name                = format("%s-queue-endpoint", module.io_citizen_auth_storage.name)
  location            = var.location
  resource_group_name = azurerm_resource_group.data_rg.name
  subnet_id           = data.azurerm_subnet.private_endpoints_subnet.id

  private_service_connection {
    name                           = format("%s-queue", module.io_citizen_auth_storage.name)
    private_connection_resource_id = module.io_citizen_auth_storage.id
    is_manual_connection           = false
    subresource_names              = ["queue"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_queue_core_windows_net.id]
  }

  tags = var.tags
}

resource "azurerm_storage_table" "profile_emails" {
  depends_on           = [module.io_citizen_auth_storage, azurerm_private_endpoint.table]
  name                 = "profileEmails"
  storage_account_name = module.io_citizen_auth_storage.name
}

resource "azurerm_storage_queue" "profiles_to_sanitize" {
  depends_on           = [module.io_citizen_auth_storage, azurerm_private_endpoint.queue]
  name                 = "profiles-to-sanitize"
  storage_account_name = module.io_citizen_auth_storage.name
}
