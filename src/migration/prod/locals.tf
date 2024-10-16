locals {
  prefix             = "io"
  env_short          = "p"
  location_short     = { westeurope = "weu", italynorth = "itn", germanywestcentral = "gwc", northeurope = "neu" }
  project_itn        = "${local.prefix}-${local.env_short}-${local.location_short.italynorth}"
  project_weu        = "${local.prefix}-${local.env_short}-${local.location_short.westeurope}"
  project_weu_legacy = "${local.prefix}-${local.env_short}"
  secondary_project  = "${local.prefix}-${local.env_short}-${local.location_short.germanywestcentral}"

  environment = {
    prefix          = local.prefix
    env_short       = local.env_short
    location        = "italynorth"
    domain          = "eng"
    app_name        = "migitn"
    instance_number = "01"
  }

  tags = {
    CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
    CreatedBy   = "Terraform"
    Environment = "Prod"
    Owner       = "IO"
    Source      = "https://github.com/pagopa/io-infra/blob/main/src/migration/prod"
  }

  storage_accounts = [
    # Copy both containers and tables
    # {
    #   source = { name = "stdevbiptest1", resource_group_name = "RG-BIP-DEV-TEST" }
    #   target = { name = "stbipdevtest1", resource_group_name = "dev-fasanorg" }
    # },
    #
    # Copy only selected containers and tables
    # {
    #   source = { name = "stdevbiptest1", resource_group_name = "RG-BIP-DEV-TEST" }
    #   target = { name = "stbipdevtest1", resource_group_name = "dev-fasanorg" }
    #   blob = {enabled = true, containers = ["c1", "c2", "c3"]}
    #   table = {enabled = true, tables = ["t1", "t2", "t3"]}
    # }
  ]
}
