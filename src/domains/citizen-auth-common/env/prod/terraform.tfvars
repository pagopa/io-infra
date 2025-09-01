prefix         = "io"
env_short      = "p"
env            = "prod"
domain         = "citizen-auth"
location       = "westeurope"
location_short = "weu"
location_full  = "West Europe"
instance       = "common"

tags = {
  CreatedBy      = "Terraform"
  Environment    = "Prod"
  ManagementTeam = "IO Autenticazione"
  BusinessUnit   = "App IO"
  Source         = "https://github.com/pagopa/io-infra/tree/main/src/citizen-auth-common"
  CostCenter     = "TS000 - Tecnologia e Servizi"
}

### Cosmos DB

citizen_auth_database = {
  lollipop_pubkeys = {
    max_throughput = 9000
    ttl            = -1
  }
  session_notifications = {
    max_throughput = 9000
    ttl            = -1
  }
}

### External resources

monitor_resource_group_name                 = "io-p-rg-common"
log_analytics_workspace_name                = "io-p-law-common"
log_analytics_workspace_resource_group_name = "io-p-rg-common"
application_insights_name                   = "io-p-ai-common"

# Redis Common
# You can retrieve the list of current defined subnets using the CLI command
# az network vnet subnet list --subscription PROD-IO --vnet-name io-p-vnet-common --resource-group io-p-rg-common --output table
# and thus define new CIDRs according to the unallocated address space
cidr_subnet_redis_common_itn = ["10.20.17.0/24"]
