module "cosmos" {
  source = "../../_modules/cosmos"

  project             = local.project
  location            = local.location
  additional_location = local.secondary_location
  resource_group_name = module.resource_groups.resource_group_cgn.name

  private_endpoint_subnet_id = module.networking.subnet_pendpoints.id

  tags = local.tags
}
