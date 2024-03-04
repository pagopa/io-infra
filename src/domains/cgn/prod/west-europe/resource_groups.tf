module "resource_groups" {
  source = "../../_modules/resource_groups"

  env_short = local.env_short
  location  = local.location
  project   = local.project

  tags = local.tags
}
