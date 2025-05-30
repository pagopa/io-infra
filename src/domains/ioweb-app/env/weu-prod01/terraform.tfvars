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

### External tools

# chart releases: https://github.com/stakater/Reloader/releases
# image tags: https://hub.docker.com/r/stakater/reloader/tags
reloader_helm = {
  chart_version = "v1.0.41"
  image_name    = "stakater/reloader"
  image_tag     = "v1.0.41@sha256:eb7e816f4c38d9c9c25fd8743919075d8ea699d8593f261c7c2e0b52080c6c47"
}
# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
tls_cert_check_helm = {
  chart_version = "1.21.0"
  image_name    = "ghcr.io/pagopa/infra-ssl-check"
  image_tag     = "v1.3.4@sha256:c3d45736706c981493b6216451fc65e99a69d5d64409ccb1c4ca93fef57c921d"
}

### Aks

ingress_load_balancer_ip = "10.11.0.254"
