module "networking" {
  source = "../../_modules/networking"

  location = local.location
  project  = local.project

  cidr_subnet_selfcare_be = "10.0.137.0/24"

  tags = local.tags
}
