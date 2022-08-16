resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.domain
  }
}

module "pod_identity" {
  source = "git::https://github.com/pagopa/azurerm.git//kubernetes_pod_identity?ref=v2.13.1"

  resource_group_name = local.aks_resource_group_name
  location            = var.location
  tenant_id           = data.azurerm_subscription.current.tenant_id
  cluster_name        = local.aks_name

  identity_name = "${var.domain}-pod-identity"
  namespace     = kubernetes_namespace.namespace.metadata[0].name
  key_vault     = data.azurerm_key_vault.kv

  secret_permissions = ["get"]
}

resource "helm_release" "reloader" {
  name       = "reloader"
  repository = "https://stakater.github.io/stakater-charts"
  chart      = "reloader"
  version    = var.reloader_helm.chart_version
  namespace  = kubernetes_namespace.namespace.metadata[0].name

  set {
    name  = "reloader.watchGlobally"
    value = "false"
  }
  set {
    name  = "reloader.deployment.image.name"
    value = var.reloader_helm.image_name
  }
  set {
    name  = "reloader.deployment.image.tag"
    value = var.reloader_helm.image_tag
  }
}

resource "helm_release" "tls_cert_check" {
  name       = "tls-cert-check"
  chart      = "microservice-chart"
  repository = "https://pagopa.github.io/aks-microservice-chart-blueprint"
  version    = var.tls_cert_check_helm.chart_version
  namespace  = kubernetes_namespace.namespace.metadata[0].name

  values = [
    "${templatefile("${path.module}/templates/tls-cert.yaml.tpl",
      {
        namespace                      = var.domain
        image_name                     = var.tls_cert_check_helm.image_name
        image_tag                      = var.tls_cert_check_helm.image_tag
        website_site_name              = "tls-cert-check-${var.location_short}${var.instance}.${var.domain}.internal.io.pagopa.it"
        time_trigger                   = "*/1 * * * *"
        function_name                  = "${var.location_short}${var.instance}.${var.domain}.internal.io.pagopa.it"
        region                         = var.location_string
        expiration_delta_in_days       = "7"
        host                           = "${var.location_short}${var.instance}.${var.domain}.internal.io.pagopa.it"
        appinsights_instrumentationkey = "appinsights-connection-string"
        keyvault_name                  = data.azurerm_key_vault.kv.name
        keyvault_tenantid              = data.azurerm_client_config.current.tenant_id
    })}",
  ]
}

resource "azurerm_monitor_metric_alert" "tls_cert_check" {
  name                = "tls-cert-check-${var.location_short}${var.instance}.${var.domain}.internal.io.pagopa.it"
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
  scopes              = [data.azurerm_application_insights.application_insights.id]
  description         = "Whenever the average availabilityresults/availabilitypercentage is less than 100%"
  severity            = 0
  frequency           = "PT5M"
  auto_mitigate       = false

  criteria {
    metric_namespace = "microsoft.insights/components"
    metric_name      = "availabilityResults/availabilityPercentage"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 50

    dimension {
      name     = "availabilityResult/name"
      operator = "Include"
      values   = ["${var.location_short}${var.instance}.${var.domain}.internal.io.pagopa.it"]
    }
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.email.id
  }
}
