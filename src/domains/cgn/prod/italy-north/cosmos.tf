module "cosmos" {
  source = "../../_modules/cosmos"

  env_short                = "p"
  region                   = "italynorth"
  resource_group_name      = module.resource_groups.name
  subnet_id                = module.networking.subnet.id
  private_dns_zone_sql_ids = module.networking.private_dns_zones.privatelink_documents.id

  tags = var.tags
}
