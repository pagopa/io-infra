resource "azurerm_storage_account" "terraform" {
  name                = replace("${var.project}tfst001", "-", "")
  resource_group_name = var.resource_group_name
  location            = var.location

  account_tier             = "Standard"
  access_tier              = "Hot"
  account_kind             = "StorageV2"
  account_replication_type = "ZRS"

  allow_nested_items_to_be_public  = false
  cross_tenant_replication_enabled = false

  tags = var.tags
}
