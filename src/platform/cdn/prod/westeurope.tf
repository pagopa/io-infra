module "common" {
  source                  = "../_modules/common"
  resource_group_cdn      = local.core.resource_groups.westeurope.common
  resource_group_external = local.core.resouce_grops.westeurope.external
  public_dns_zones        = "" # TODO
  tags                    = local.tags
}