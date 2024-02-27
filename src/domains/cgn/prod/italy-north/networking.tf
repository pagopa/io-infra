module "networking" {
  source = "../../_modules/networking"

  env_short              = local.env_short
  cidr_subnet_pendpoints = ["10.0.240.0/23"]

  tags = local.tags
}
