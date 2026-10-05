prefix         = "io"
env_short      = "p"
domain         = "citizen-auth"
location       = "westeurope"
location_short = "weu"

tags = {
  CreatedBy      = "Terraform"
  Environment    = "Prod"
  BusinessUnit   = "App IO"
  ManagementTeam = "IO Autenticazione"
  Source         = "https://github.com/pagopa/io-infra/tree/main/src/citizen-auth"
  CostCenter     = "TS000 - Tecnologia e Servizi"
}

### External resources

monitor_resource_group_name = "io-p-rg-common"
application_insights_name   = "io-p-ai-common"

# Session manager
session_manager_plan_sku_name   = "P2v3"
cidr_subnet_session_manager     = ["10.0.149.0/26"]
cidr_subnet_session_manager_bis = ["10.0.150.0/26"]

# DNS
external_domain = "pagopa.it"
dns_zone_io     = "io"
