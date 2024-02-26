module "resource_groups" {
  source = "../../_modules/resource_groups"

  env_short = "p"
  region    = "italynorth"

  tags = var.tags
}
