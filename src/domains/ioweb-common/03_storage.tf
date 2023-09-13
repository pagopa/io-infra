
######################
# SPID LOGS Storage
######################
module "spid_logs_storage" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//storage_account?ref=v6.1.0"

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

  tags = var.tags
}

# Containers
resource "azurerm_storage_container" "spid_logs" {
  depends_on            = [module.spid_logs_storage]
  name                  = "spidlogs"
  storage_account_name  = module.spid_logs_storage.name
  container_access_type = "private"
}