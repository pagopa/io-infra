prefix         = "io"
env_short      = "p"
env            = "prod"
domain         = "ioweb"
location       = "westeurope"
location_short = "weu"
instance       = "common"

tags = {
  CreatedBy      = "Terraform"
  Environment    = "Prod"
  BusinessUnit   = "App IO"
  Source         = "https://github.com/pagopa/io-infra/tree/main/src/domains/ioweb-common"
  ManagementTeam = "IO Autenticazione"
  CostCenter     = "TS000 - Tecnologia e Servizi"
}

### External resources

monitor_resource_group_name                 = "io-p-rg-common"
log_analytics_workspace_name                = "io-p-law-common"
log_analytics_workspace_resource_group_name = "io-p-rg-common"
application_insights_name                   = "io-p-ai-common"


# You can retrieve the list of current defined subnets using the CLI command
# az network vnet subnet list --subscription PROD-IO --vnet-name io-p-vnet-common --resource-group io-p-rg-common --output table
# and thus define new CIDRs according to the unallocated address space
subnets_cidrs = {
  spid_login       = ["10.0.114.0/24"]
  redis_spid_login = ["10.0.116.0/24"]
}

app_gateway_host_name = "api-web.io.pagopa.it"
