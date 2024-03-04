module "networking" {
  source = "../../_modules/networking"

  env_short              = local.env_short
  cidr_subnet_pendpoints = ["10.0.240.0/23"]
  cidr_subnet_redis      = ["10.0.14.0/25"]
  cidr_subnet_cgn        = ["10.0.8.0/26"]
  project                = local.project

  tags = local.tags
}
