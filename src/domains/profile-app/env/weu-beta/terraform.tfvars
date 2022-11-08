prefix          = "io"
env_short       = "p"
env             = "prod"
domain          = "profile"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "beta"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "IO"
  Source      = "https://github.com/pagopa/io-infra/tree/main/src/profile"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name                 = "io-p-rg-common"
log_analytics_workspace_name                = "io-p-law-common"
log_analytics_workspace_resource_group_name = "io-p-rg-common"
application_insights_name                   = "io-p-ai-common"

### External tools

# chart releases: https://github.com/stakater/Reloader/releases
# image tags: https://hub.docker.com/r/stakater/reloader/tags
reloader_helm = {
  chart_version = "v0.0.118"
  image_name    = "stakater/reloader"
  image_tag     = "v0.0.118@sha256:2d423cab8d0e83d1428ebc70c5c5cafc44bd92a597bff94007f93cddaa607b02"
}
# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
tls_cert_check_helm = {
  chart_version = "1.21.0"
  image_name    = "ghcr.io/pagopa/infra-ssl-check"
  image_tag     = "v1.2.2@sha256:22f4b53177cc8891bf10cbd0deb39f60e1cd12877021c3048a01e7738f63e0f9"
}

### Aks

ingress_load_balancer_ip = "10.10.100.250"
