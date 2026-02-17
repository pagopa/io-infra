module "redis_common_backup_zrs" {
  source = "github.com/pagopa/terraform-azurerm-v4//storage_account?ref=v1.23.3"

  name                            = try(local.nonstandard[var.location_short].storage_account, "${var.project}-redis-common-st-01")
  account_kind                    = "StorageV2"
  account_tier                    = "Premium"
  access_tier                     = "Hot"
  account_replication_type        = "ZRS"
  resource_group_name             = var.resource_group_common
  location                        = var.location
  advanced_threat_protection      = true
  use_legacy_defender_version     = false
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = true

  tags = var.tags
}

module "redis_common_backup_zrs_itn" {
  source = "github.com/pagopa/dx//infra/modules/azure_storage_account?ref=main"

  environment                          = local.itn_environment
  resource_group_name                  = var.resource_group_common
  tier                                 = "l"
  subnet_pep_id                        = module.common_values.pep_subnets.itn.id
  private_dns_zone_resource_group_name = module.common_values.resource_groups.weu.common

  subservices_enabled = {
    blob  = true
    file  = false
    queue = false
    table = false
  }

  force_public_network_access_enabled = true

  tags = var.tags
}