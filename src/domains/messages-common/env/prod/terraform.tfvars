prefix         = "io"
env_short      = "p"
env            = "prod"
domain         = "messages"
location       = "westeurope"
location_short = "weu"
instance       = "common"

tags = {
  CreatedBy      = "Terraform"
  Environment    = "Prod"
  Owner          = "IO"
  Source         = "https://github.com/pagopa/io-infra/tree/main/src/messages-common"
  CostCenter     = "TS310 - PAGAMENTI & SERVIZI"
  ManagementTeam = "IO Comunicazione"
}

### External resources

monitor_resource_group_name                 = "io-p-rg-common"
log_analytics_workspace_name                = "io-p-law-common"
log_analytics_workspace_resource_group_name = "io-p-rg-common"
application_insights_name                   = "io-p-ai-common"
