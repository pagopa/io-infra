module "subnet_addrs" {
  source = "hashicorp/subnets/cidr"

  base_cidr_block = "10.20.0.0/16"
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
