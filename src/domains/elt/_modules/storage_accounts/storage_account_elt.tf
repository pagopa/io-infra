#tfsec:ignore:azure-storage-default-action-deny
#tfsec:ignore:azure-storage-queue-services-logging-enabled:exp:2022-05-01 # already ignored, maybe a bug in tfsec
module "storage_account_elt" {
  source = "github.com/pagopa/terraform-azurerm-v3//storage_account?ref=v7.67.1"

  name                = replace(format("%s-stelt", var.project), "-", "")
  resource_group_name = var.resource_group_name
  location            = var.location

  account_kind                  = "StorageV2"
  account_tier                  = "Standard"
  account_replication_type      = "GZRS"
  access_tier                   = "Hot"
  advanced_threat_protection    = true
  public_network_access_enabled = true

  tags = var.tags
}
