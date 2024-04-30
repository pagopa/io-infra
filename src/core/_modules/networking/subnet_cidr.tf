module "subnet_addrs" {
  source = "hashicorp/subnets/cidr"

  base_cidr_block = var.vnet_cidr_block
  networks = [
    # {
    #   name     = "foo"
    #   new_bits = 8
    # },
    # {
    #   name     = "bar"
    #   new_bits = 8
    # },
  ]
}
