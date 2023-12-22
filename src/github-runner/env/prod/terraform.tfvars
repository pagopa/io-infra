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

github_runner = {
  pat_secret_name   = "github-runner-pat"
  subnet_cidr_block = "10.0.242.0/23"
}

resource_group_common_name = "io-p-rg-common"
key_vault_common_name      = "io-p-kv-common"
vnet_common_name           = "io-p-vnet-common"
law_common_name            = "io-p-law-common"
