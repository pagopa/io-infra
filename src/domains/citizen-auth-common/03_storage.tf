resource "azurerm_resource_group" "lollipop_assertions_rg" {
  name     = format("%s-lollipop-common-rg", local.common_project)
  location = var.location

  tags = var.tags
}

module "lollipop_assertions_storage" {
  source                     = "git::https://github.com/pagopa/terraform-azurerm-v3//storage_account?ref=v4.3.1"
  name                       = replace(format("%s-assertions", local.common_project), "-", "")
  domain                     = upper(var.domain)
  account_kind               = "StorageV2"
  account_tier               = "Standard"
  access_tier                = "Hot"
  account_replication_type   = "GZRS"
  resource_group_name        = azurerm_resource_group.lollipop_assertions_rg.name
  location                   = var.location
  advanced_threat_protection = true
  enable_identity            = true

  tags = var.tags
}

module "lollipop_assertions_storage_customer_managed_key" {
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3//storage_account_customer_managed_key?ref=v4.3.1"
  tenant_id            = data.azurerm_subscription.current.tenant_id
  location             = var.location
  resource_group_name  = azurerm_resource_group.lollipop_assertions_rg.name
  key_vault_id         = module.key_vault.id
  key_name             = format("$s-key", module.lollipop_assertions_storage.name)
  storage_id           = module.lollipop_assertions_storage.id
  storage_principal_id = module.lollipop_assertions_storage.identity.0.principal_id
}

resource "azurerm_private_endpoint" "lollipop_assertion_storage_blob" {
  name                = "${module.lollipop_assertions_storage.name}-blob-endpoint"
  location            = var.location
  resource_group_name = azurerm_resource_group.lollipop_assertions_rg.name
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

resource "azurerm_storage_container" "lollipop_assertions_storage_assertions" {
  name                  = "assertions"
  storage_account_name  = module.lollipop_assertions_storage.name
  container_access_type = "private"
}