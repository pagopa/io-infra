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
# LV Audit Log Storage
###
module "lv_audit_logs_storage" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//storage_account?ref=v6.1.0"

  name                          = replace(format("%s-lv-logs-st", local.product), "-", "")
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

module "lv_audit_logs_storage_customer_managed_key" {
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3//storage_account_customer_managed_key?ref=v4.3.1"
  tenant_id            = data.azurerm_subscription.current.tenant_id
  location             = var.location
  resource_group_name  = azurerm_resource_group.data_rg.name
  key_vault_id         = module.key_vault.id
  key_name             = format("%s-key", module.lv_audit_logs_storage.name)
  storage_id           = module.lv_audit_logs_storage.id
  storage_principal_id = module.lv_audit_logs_storage.identity.0.principal_id
}

resource "azurerm_private_endpoint" "lv_audit_logs_storage_blob" {
  name                = "${module.lv_audit_logs_storage.name}-blob-endpoint"
  location            = var.location
  resource_group_name = azurerm_resource_group.data_rg.name
  subnet_id           = data.azurerm_subnet.private_endpoints_subnet.id

  private_service_connection {
    name                           = "${module.lv_audit_logs_storage.name}-blob"
    private_connection_resource_id = module.lv_audit_logs_storage.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_blob_core_windows_net.id]
  }

  tags = var.tags
}

resource "azurerm_storage_container" "lv_audit_logs_storage_logs" {
  name                  = "logs"
  storage_account_name  = module.lv_audit_logs_storage.name
  container_access_type = "private"
}

###
# Unique Emails Storage
###
module "unique_emails_storage" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//storage_account?ref=v6.1.0"

  name                          = replace(format("%s-unique-emails-st", local.product), "-", "")
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

resource "azurerm_private_endpoint" "unique_emails_storage_table" {
  depends_on          = [module.unique_emails_storage]
  name                = "${module.unique_emails_storage.name}-table-endpoint"
  location            = var.location
  resource_group_name = azurerm_resource_group.data_rg.name
  subnet_id           = data.azurerm_subnet.private_endpoints_subnet.id

  private_service_connection {
    name                           = "${module.unique_emails_storage.name}-table"
    private_connection_resource_id = module.unique_emails_storage.id
    is_manual_connection           = false
    subresource_names              = ["table"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_table_core.id]
  }

  tags = var.tags
}

resource "azurerm_storage_table" "unique_emails_storage_unique_emails_table" {
  depends_on           = [module.unique_emails_storage]
  name                 = "uniqueEmails"
  storage_account_name = module.unique_emails_storage.name
}
