module "common" {
  source                  = "../_modules/common"
  resource_group_cdn      = local.core.resource_groups.westeurope.common
  resource_group_external = local.core.resource_groups.westeurope.external
  public_dns_zones        = local.common.public_dns_zones
  tags                    = local.tags
}