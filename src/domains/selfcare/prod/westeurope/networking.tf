module "networking" {
  source = "../../_modules/networking"

  location = local.location
  project  = local.project

  # inferred from vnet-common with cidr 10.0.0.0/16
  # https://github.com/pagopa/io-infra/blob/d5101ef7b24bc262b8a7773a9690a00afe9ec92e/src/core/network.tf#L8
  cidr_subnet_selfcare_be      = "10.0.137.0/24"
  cidr_subnet_developer_portal = "10.0.138.0/24"

  tags = local.tags
}
