module "storage_account_cosmos_backup" {
  source = "github.com/pagopa/terraform-azurerm-v3//storage_account?ref=v8.36.1"

  name                = "${replace(var.project, "-", "")}stcosmosbonusbackup"
  resource_group_name = var.resource_group_name
  location            = var.location

  account_kind                         = "StorageV2"
  account_tier                         = "Standard"
  access_tier                          = "Cool"
  account_replication_type             = "GRS"
  public_network_access_enabled        = false
  allow_nested_items_to_be_public      = true
  use_legacy_defender_version          = false
  blob_container_delete_retention_days = 7
  blob_delete_retention_days           = 7

  enable_low_availability_alert = false

  tags = var.tags
}
