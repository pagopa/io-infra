module "cosmos" {
  source = "../../_modules/cosmos"

  project                  = local.project
  location                 = local.location
  additional_location      = local.secondary_location
  resource_group_name      = module.resource_groups.resource_group_cgn.name
  subnet_id                = module.networking.subnet_pendpoints.id
  private_dns_zone_sql_ids = module.networking.private_dns_zones.privatelink_documents.id

  tags = local.tags
}
