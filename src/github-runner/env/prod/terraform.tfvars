prefix    = "io"
env_short = "p"
location  = "westeurope"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "IO"
  Source      = "https://github.com/pagopa/io-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

resource_group_common_name = "io-p-rg-common"

key_vault_common = {
  name            = "io-p-kv-common"
  pat_secret_name = "github-runner-pat"
}

networking = {
  vnet_common_name  = "io-p-vnet-common"
  subnet_cidr_block = "10.0.242.0/23"
}

law_common_name = "io-p-law-common"
