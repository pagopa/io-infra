module "networking" {
  source = "../../_modules/networking"

  project           = local.project
  cidr_subnet_redis = ["10.0.14.0/25"]
  cidr_subnet_cgn   = ["10.0.8.0/26"]

  tags = local.tags
}
