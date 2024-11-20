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
    app_name        = "migration"
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
    #   source = { name = "<SOURCE_STORAGE_ACCOUNT_NAME>", resource_group_name = "<SOURCE_STORAGE_ACCOUNT_RG_NAME>" }
    #   target = { name = "<TARGET_STORAGE_ACCOUNT_NAME>", resource_group_name = "<TARGET_STORAGE_ACCOUNT_RG_NAME>" }
    # },
    #
    # Copy only selected containers and tables
    # {
    #   source = { name = "<SOURCE_STORAGE_ACCOUNT_NAME>", resource_group_name = "<SOURCE_STORAGE_ACCOUNT_RG_NAME>" }
    #   target = { name = "<TARGET_STORAGE_ACCOUNT_NAME>", resource_group_name = "<TARGET_STORAGE_ACCOUNT_RG_NAME>" }
    #   blob = {enabled = true, containers = ["c1", "c2", "c3"]}
    #   table = {enabled = true, tables = ["t1", "t2", "t3"]}
    # }
  ]

  cosmos_accounts = [
    # Copy all databases (with write_behavior to insert)
    # {
    #   source = { name = "<SOURCE_COSMOS_ACCOUNT_NAME>", resource_group_name = "<SOURCE_COSMOS_ACCOUNT_RG_NAME>" }
    #   target = { name = "<TARGET_COSMOS_ACCOUNT_NAME>", resource_group_name = "<TARGET_COSMOS_ACCOUNT_RG_NAME>", write_behavior = "insert" }
    # },
    # Copy only selected databases (with write_behavior defaulting to upsert)
    # {
    #   source = { name = "<SOURCE_COSMOS_ACCOUNT_NAME>", resource_group_name = "<SOURCE_COSMOS_ACCOUNT_RG_NAME>" }
    #   target = { name = "<TARGET_COSMOS_ACCOUNT_NAME>", resource_group_name = "<TARGET_COSMOS_ACCOUNT_RG_NAME>" }
    #   databases = ["db1", "db2", "db3"]
    # }
  ]
}
