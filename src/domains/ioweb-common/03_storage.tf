
######################
# SPID LOGS Storage
######################
module "spid_logs_storage" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//storage_account?ref=v7.32.1"

  name                          = replace(format("%s-spid-logs-st", local.project), "-", "")
  domain                        = upper(var.domain)
  account_kind                  = "StorageV2"
  account_tier                  = "Standard"
  access_tier                   = "Hot"
  account_replication_type      = "GZRS"
  resource_group_name           = azurerm_resource_group.storage_rg.name
  location                      = var.location
  advanced_threat_protection    = true
  enable_identity               = true
  public_network_access_enabled = false

  blob_storage_policy = {
    enable_immutability_policy = true
    blob_restore_policy_days   = 0
  }

  tags = var.tags
}

module "spid_logs_storage_customer_managed_key" {
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3//storage_account_customer_managed_key?ref=v7.32.1"
  tenant_id            = data.azurerm_subscription.current.tenant_id
  location             = var.location
  resource_group_name  = azurerm_resource_group.storage_rg.name
  key_vault_id         = module.key_vault.id
  key_name             = format("%s-key", module.spid_logs_storage.name)
  storage_id           = module.spid_logs_storage.id
  storage_principal_id = module.spid_logs_storage.identity.0.principal_id
}


resource "azurerm_private_endpoint" "spid_logs_storage_blob" {
  name                = "${module.spid_logs_storage.name}-blob-endpoint"
  location            = var.location
  resource_group_name = azurerm_resource_group.storage_rg.name
  subnet_id           = data.azurerm_subnet.private_endpoints_subnet.id

  private_service_connection {
    name                           = "${module.spid_logs_storage.name}-blob"
    private_connection_resource_id = module.spid_logs_storage.id
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
resource "azurerm_storage_container" "spid_logs" {
  depends_on            = [module.spid_logs_storage]
  name                  = "spidlogs"
  storage_account_name  = module.spid_logs_storage.name
  container_access_type = "private"
}