resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  version    = var.prometheus_helm.chart_version
  namespace  = kubernetes_namespace.monitoring.metadata[0].name

  set {
    name  = "server.global.scrape_interval"
    value = "30s"
  }
  set {
    name  = "alertmanager.image.repository"
    value = var.prometheus_helm.alertmanager.image_name
  }
  set {
    name  = "alertmanager.image.tag"
    value = var.prometheus_helm.alertmanager.image_tag
  }
  set {
    name  = "alertmanager.configmapReload.prometheus.image.repository"
    value = var.prometheus_helm.configmap_reload_prometheus.image_name
  }
  set {
    name  = "alertmanager.configmapReload.prometheus.image.tag"
    value = var.prometheus_helm.configmap_reload_prometheus.image_tag
  }
  set {
    name  = "alertmanager.configmapReload.alertmanager.image.repository"
    value = var.prometheus_helm.configmap_reload_alertmanager.image_name
  }
  set {
    name  = "alertmanager.configmapReload.alertmanager.image.tag"
    value = var.prometheus_helm.configmap_reload_alertmanager.image_tag
  }
  set {
    name  = "alertmanager.nodeExporter.image.repository"
    value = var.prometheus_helm.node_exporter.image_name
  }
  set {
    name  = "alertmanager.nodeExporter.image.tag"
    value = var.prometheus_helm.node_exporter.image_tag
  }
  set {
    name  = "alertmanager.nodeExporter.image.repository"
    value = var.prometheus_helm.node_exporter.image_name
  }
  set {
    name  = "alertmanager.nodeExporter.image.tag"
    value = var.prometheus_helm.node_exporter.image_tag
  }
  set {
    name  = "alertmanager.server.image.repository"
    value = var.prometheus_helm.server.image_name
  }
  set {
    name  = "alertmanager.server.image.tag"
    value = var.prometheus_helm.server.image_tag
  }
  set {
    name  = "alertmanager.pushgateway.image.repository"
    value = var.prometheus_helm.pushgateway.image_name
  }
  set {
    name  = "alertmanager.pushgateway.image.tag"
    value = var.prometheus_helm.pushgateway.image_tag
  }
}

# resource "helm_release" "grafana" {
#   name       = "grafana"
#   repository = "https://grafana.github.io/helm-charts"
#   chart      = "grafana"
#   version    = var.grafana_helm_version
#   namespace  = kubernetes_namespace.monitoring.metadata[0].name

#   set {
#     name  = "adminUser"
#     value = data.azurerm_key_vault_secret.grafana_admin_username.value
#   }

#   set {
#     name  = "adminPassword"
#     value = data.azurerm_key_vault_secret.grafana_admin_password.value
#   }
# }

resource "helm_release" "tls_cert_check_api-app_internal_io_pagopa_it" {
  name       = "tls-cert-check-api-app-internal-io-pagopa-it"
  chart      = "microservice-chart"
  repository = "https://pagopa.github.io/aks-microservice-chart-blueprint"
  version    = var.tls_cert_check_helm.chart_version
  namespace  = kubernetes_namespace.monitoring.metadata[0].name

  values = [
    "${templatefile("${path.module}/templates/tls-cert.yaml.tpl",
      {
        namespace                      = kubernetes_namespace.monitoring.metadata[0].name
        image_name                     = var.tls_cert_check_helm.image_name
        image_tag                      = var.tls_cert_check_helm.image_tag
        website_site_name              = "tls-cert-check-api-app.internal.io.pagopa.it"
        time_trigger                   = "*/15 * * * *"
        function_name                  = "api-app.internal.io.pagopa.it"
        region                         = var.location_string
        expiration_delta_in_days       = "7"
        host                           = "api-app.internal.io.pagopa.it"
        appinsights_instrumentationkey = data.azurerm_application_insights.application_insights.connection_string
    })}",
  ]
}

resource "helm_release" "tls_cert_check_api-internal_io_italia_it" {
  name       = "tls-cert-check-api-internal-io-italia-it"
  chart      = "microservice-chart"
  repository = "https://pagopa.github.io/aks-microservice-chart-blueprint"
  version    = var.tls_cert_check_helm.chart_version
  namespace  = kubernetes_namespace.monitoring.metadata[0].name

  values = [
    "${templatefile("${path.module}/templates/tls-cert.yaml.tpl",
      {
        namespace                      = kubernetes_namespace.monitoring.metadata[0].name
        image_name                     = var.tls_cert_check_helm.image_name
        image_tag                      = var.tls_cert_check_helm.image_tag
        website_site_name              = "tls-cert-check-api-internal.io.italia.it"
        time_trigger                   = "*/15 * * * *"
        function_name                  = "api-internal.io.italia.it"
        region                         = var.location_string
        expiration_delta_in_days       = "7"
        host                           = "api-internal.io.italia.it"
        appinsights_instrumentationkey = data.azurerm_application_insights.application_insights.connection_string
    })}",
  ]
}
