prefix          = "io"
env_short       = "p"
env             = "prod"
domain          = "ioweb"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "prod01"

tags = {
  CreatedBy      = "Terraform"
  Environment    = "Prod"
  BusinessUnit   = "App IO"
  Source         = "https://github.com/pagopa/io-infra/tree/main/src/domains/ioweb-app"
  ManagementTeam = "IO Autenticazione"
  CostCenter     = "TS000 - Tecnologia e Servizi"
}

### External resources

monitor_resource_group_name                 = "io-p-rg-common"
log_analytics_workspace_name                = "io-p-law-common"
log_analytics_workspace_resource_group_name = "io-p-rg-common"
application_insights_name                   = "io-p-ai-common"

enable_azdoa = true
