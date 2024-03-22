module "networking" {
  source = "../../_modules/networking"

  project = local.project

  # inferred from vnet-common with cidr 10.0.0.0/16
  # https://github.com/pagopa/io-infra/blob/d5101ef7b24bc262b8a7773a9690a00afe9ec92e/src/core/network.tf#L8
  cidr_subnet_eucovidcert = "10.0.132.192/26"
}
