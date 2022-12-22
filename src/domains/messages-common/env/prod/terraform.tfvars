prefix         = "io"
env_short      = "p"
env            = "prod"
domain         = "messages"
location       = "westeurope"
location_short = "weu"
instance       = "common"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "IO"
  Source      = "https://github.com/pagopa/io-infra/tree/main/src/messages-common"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name                 = "io-p-rg-common"
log_analytics_workspace_name                = "io-p-law-common"
log_analytics_workspace_resource_group_name = "io-p-rg-common"
application_insights_name                   = "io-p-ai-common"
nh_resource_group_name                      = "io-p-rg-common"
nh_name_prefix                              = "io-p-ntf"
nh_namespace_prefix                         = "io-p-ntfns"
nh_partition_count                          = 4

cidr_subnet_push_notif                     = ["10.0.140.0/24"]