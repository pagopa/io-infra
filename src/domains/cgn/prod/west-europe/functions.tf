module "functions" {
  source = "../../_modules/functions"

  env_short                = local.env_short
  location                 = local.location
  resource_group_name      = module.resource_groups.resource_group_be_cgn.name

  tags = local.tags
}
