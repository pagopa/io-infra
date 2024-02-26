module "networking" {
  source = "../../_modules/networking"

  env_short                = local.env_short
  vnet_resource_group_name = "io-p-vnet-common"
  cidr_subnet_pendpoints   = ["10.0.240.0/23"]

  tags = local.tags
}
