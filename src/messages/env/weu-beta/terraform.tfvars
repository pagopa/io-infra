prefix          = "io"
env_short       = "p"
env             = "prod"
domain          = "messages"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "beta"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "IO"
  Source      = "https://github.com/pagopa/io-infra/tree/main/src/messages"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

lock_enable = true

terraform_remote_state_core = {
  resource_group_name  = "io-infra-rg"
  storage_account_name = "ioinfrastterraform"
  container_name       = "azurermstate"
  key                  = "terraform.tfstate"
}

### External resources

monitor_resource_group_name                 = "io-p-rg-common"
log_analytics_workspace_name                = "io-p-law-common"
log_analytics_workspace_resource_group_name = "io-p-rg-common"

### External tools

reloader_helm_version  = "v0.0.110"
tls_cert_chart_version = "1.20.3"
tls_cert_image_tag     = "v1.2.1@sha256:fddc9bed6bb24a88635102fb38b672c1b1abdfd67b100fa0a8ce3bd13ecf09e1"

### Aks

ingress_load_balancer_ip = "10.10.100.250"
