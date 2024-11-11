module "storage_account_eucovidcert" {
  source = "github.com/pagopa/terraform-azurerm-v3//storage_account?ref=v7.69.1"

  name                            = "${replace(var.project, "-", "")}steucovidcert"
  account_kind                    = "StorageV2"
  account_tier                    = "Standard"
  access_tier                     = "Hot"
  blob_versioning_enabled         = false
  account_replication_type        = "GZRS"
  resource_group_name             = var.resource_group_name
  location                        = var.location
  advanced_threat_protection      = false
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = true

  tags = var.tags
}

module "storage_account_eucovidcert_itn" {
  source = "github.com/pagopa/dx//infra/modules/azure_storage_account?ref=main"

  environment         = local.itn_environment
  resource_group_name = var.resource_group_name
  access_tier         = "Hot"

  subnet_pep_id                        = module.common_values.pep_subnets.itn.id
  private_dns_zone_resource_group_name = module.common_values.resource_groups.weu.common

  subservices_enabled = {
    blob  = false
    file  = false
    queue = true
    table = true
  }

  force_public_network_access_enabled = true

  tags = var.tags
}