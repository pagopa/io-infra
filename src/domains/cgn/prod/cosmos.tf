module "cosmos" {
  source = "../_modules/cosmos"

  project             = local.project
  location            = "italynorth"
  secondary_location  = "spaincentral"
  resource_group_name = module.resource_groups.resource_group_cgn.name

  private_endpoint_subnet_id     = module.networking.subnet_pendpoints.id
  private_endpoint_subnet_id_itn = module.networking.subnet_pep_itn.id

  tags = local.tags
}
