prefix          = "io"
env_short       = "p"
env             = "prod"
domain          = "prod01"
location        = "westeurope"
location_string = "West Europe"
location_short  = "weu"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "IO"
  Source      = "https://github.com/pagopa/io-infra/tree/main/src/aks"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name                 = "io-p-rg-common"
log_analytics_workspace_name                = "io-p-law-common"
log_analytics_workspace_resource_group_name = "io-p-rg-common"
application_insights_name                   = "io-p-ai-common"

### Aks

aks_kubernetes_version = "1.23.12"

aks_sku_tier = "Paid"

aks_system_node_pool = {
  name                         = "system01"
  vm_size                      = "Standard_D2ds_v5"
  os_disk_type                 = "Ephemeral"
  os_disk_size_gb              = "75"
  node_count_min               = "2"
  node_count_max               = "3"
  only_critical_addons_enabled = true
  node_labels                  = { node_name : "aks-system-01", node_type : "system" },
  node_tags                    = { node_tag_1 : "1" },
}

aks_user_node_pool = {
  enabled         = true
  name            = "user01"
  vm_size         = "Standard_D8ds_v5"
  os_disk_type    = "Ephemeral"
  os_disk_size_gb = "300"
  node_count_min  = "2"
  node_count_max  = "3"
  node_labels     = { node_name : "aks-user-01", node_type : "user" },
  node_taints     = [],
  node_tags       = { node_tag_1 : "1" },
}

aks_cidr_subnet      = ["10.11.0.0/17"]
aks_num_outbound_ips = 1

ingress_min_replica_count = "2"
ingress_max_replica_count = "30"
ingress_load_balancer_ip  = "10.11.100.250"

# ingress-nginx helm charts releases 4.X.X: https://github.com/kubernetes/ingress-nginx/releases?expanded=true&page=1&q=tag%3Ahelm-chart-4
# Pinned versions from "4.1.0" release: https://github.com/kubernetes/ingress-nginx/blob/helm-chart-4.1.0/charts/ingress-nginx/values.yaml
nginx_helm = {
  version = "4.1.0"
  controller = {
    image = {
      registry     = "k8s.gcr.io"
      image        = "ingress-nginx/controller"
      tag          = "v1.2.0"
      digest       = "sha256:d8196e3bc1e72547c5dec66d6556c0ff92a23f6d0919b206be170bc90d5f9185"
      digestchroot = "sha256:fb17f1700b77d4fcc52ca6f83ffc2821861ae887dbb87149cf5cbc52bea425e5"
    }
  }
}

# chart releases: https://github.com/kedacore/charts/releases
# keda image tags: https://github.com/kedacore/keda/pkgs/container/keda/versions
# keda-metrics-apiserver image tags: https://github.com/kedacore/keda/pkgs/container/keda-metrics-apiserver/versions
keda_helm = {
  chart_version = "2.12.0"
  keda = {
    image_name = "ghcr.io/kedacore/keda"
    image_tag  = "2.12.0@sha256:01a232774016f186ff91983521323a80ead047b42d695fc0236b43c296b6cff8"
  }
  metrics_api_server = {
    image_name = "ghcr.io/kedacore/keda-metrics-apiserver"
    image_tag  = "2.12.0@sha256:1c254dcf859b93bbcaa532fcb5d6de5ff14b67f904a7ae1068ab1dbc19f60479"
  }
}

# chart releases: https://github.com/stakater/Reloader/releases
# image tags: https://hub.docker.com/r/stakater/reloader/tags
reloader_helm = {
  chart_version = "v1.0.41"
  image_name    = "stakater/reloader"
  image_tag     = "v1.0.41@sha256:eb7e816f4c38d9c9c25fd8743919075d8ea699d8593f261c7c2e0b52080c6c47"
}

# chart releases: https://github.com/prometheus-community/helm-charts/releases?q=tag%3Aprometheus-25&expanded=true
# quay.io/prometheus/alertmanager image tags: https://quay.io/repository/prometheus/alertmanager?tab=tags
# jimmidyson/configmap-reload image tags: https://hub.docker.com/r/jimmidyson/configmap-reload/tags
# quay.io/prometheus/node-exporter image tags: https://quay.io/repository/prometheus/node-exporter?tab=tags
# quay.io/prometheus/prometheus image tags: https://quay.io/repository/prometheus/prometheus?tab=tags
# prom/pushgateway image tags:https://hub.docker.com/r/prom/pushgateway/tags
prometheus_helm = {
  chart_version = "25.0.0"
  # alertmanager = {
  #   image_name = "quay.io/prometheus/alertmanager"
  #   image_tag  = "v0.26.0@sha256:361db356b33041437517f1cd298462055580585f26555c317df1a3caf2868552"
  # }
  # configmap_reload_prometheus = {
  #   image_name = "quay.io/prometheus-operator/prometheus-config-reloader"
  #   image_tag  = "v0.67.0@sha256:14feefde1b8015de2cbdee008a19891c2af09f91b650af854e584feda9869a39"
  # }
  # configmap_reload_alertmanager = {
  #   image_name = "jimmidyson/configmap-reload"
  #   image_tag  = "v0.67.0@sha256:14feefde1b8015de2cbdee008a19891c2af09f91b650af854e584feda9869a39"
  # }
  # node_exporter = {
  #   image_name = "quay.io/prometheus/node-exporter"
  #   image_tag  = "v1.6.1@sha256:81f94e50ea37a88dfee849d0f4acad25b96b397061f59e5095905f6bc5829637"
  # }
  # server = {
  #   image_name = "quay.io/prometheus/prometheus"
  #   image_tag  = "v2.47.0@sha256:c5dd3503828713c4949ae1bccd1d8d69f382c33d441954674a6b78ebe69c3331"
  # }
  # pushgateway = {
  #   image_name = "prom/pushgateway"
  #   image_tag  = "v1.6.1@sha256:75955233a240f0c456e58c86ffc6e734deac02cd1dc7332f54a57eb931c6d5d9"
  # }
}

# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
tls_cert_check_helm = {
  chart_version = "2.0.0"
  image_name    = "ghcr.io/pagopa/infra-ssl-check"
  image_tag     = "v1.3.4@sha256:c3d45736706c981493b6216451fc65e99a69d5d64409ccb1c4ca93fef57c921d"
}

# grafana_helm_version = "6.32.3"
