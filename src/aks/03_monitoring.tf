resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  version    = var.prometheus_helm_version
  namespace  = kubernetes_namespace.monitoring.metadata[0].name

  set {
    name  = "server.global.scrape_interval"
    value = "30s"
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
