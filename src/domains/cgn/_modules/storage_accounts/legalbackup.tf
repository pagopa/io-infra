#tfsec:ignore:azure-storage-default-action-deny
#tfsec:ignore:azure-storage-queue-services-logging-enabled:exp:2022-05-01 # already ignored, maybe a bug in tfsec
module "cgn_legalbackup_storage" {
  source = "github.com/pagopa/terraform-azurerm-v3//storage_account?ref=v7.61.0"

  name                            = replace(format("%s-cgn-legalbackup-storage", local.project), "-", "")
  resource_group_name             = var.resource_group_name
  location                        = var.location

  account_kind                    = "StorageV2"
  account_tier                    = "Standard"
  access_tier                     = "Hot"
  blob_versioning_enabled         = false
  account_replication_type        = "GZRS"
  advanced_threat_protection      = false
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = true

  tags = var.tags
}
