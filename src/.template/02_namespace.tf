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
resource "azurerm_resource_group" "tls_cert_rg" {
  name     = "${local.project}-tls-rg"
  location = var.location

  tags = var.tags
}

module "tls_cert_storage" {
  source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v2.7.0"

  name                       = replace(format("%s-tls", local.project), "-", "")
  account_kind               = "StorageV2"
  account_tier               = "Standard"
  access_tier                = "Hot"
  versioning_name            = "versioning"
  enable_versioning          = false
  account_replication_type   = "ZRS"
  resource_group_name        = azurerm_resource_group.tls_cert_rg.name
  location                   = var.location
  advanced_threat_protection = true
  allow_blob_public_access   = false

  tags = var.tags
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "tls_cert_storage_connection_string" {
  name         = "${module.tls_cert_storage.name}-connection-string"
  value        = module.tls_cert_storage.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "helm_release" "tls_cert" {
  name       = "tls-cert"
  chart      = "microservice-chart"
  repository = "https://pagopa.github.io/aks-microservice-chart-blueprint"
  version    = var.tls_cert_helm.chart_version
  namespace  = kubernetes_namespace.namespace.metadata[0].name

  values = [
    "${templatefile("${path.module}/templates/tls-cert.yaml.tpl",
      {
        namespace                      = var.domain
        image_name                     = var.tls_cert_helm.image_name
        image_tag                      = var.tls_cert_helm.image_tag
        website_site_name              = "tls-cert-${var.location_short}${var.instance}${var.domain}.internal.io.pagopa.it"
        time_trigger                   = "*/30 * * * *"
        function_name                  = "${var.location_short}${var.instance}.${var.domain}.internal.io.pagopa.it"
        region                         = var.location_string
        expiration_delta_in_days       = "7"
        host                           = "${var.location_short}${var.instance}.${var.domain}.internal.io.pagopa.it"
        appinsights_instrumentationkey = "appinsights-connection-string"
        azure_web_jobs_storage         = azurerm_key_vault_secret.tls_cert_storage_connection_string.name
        keyvault_name                  = data.azurerm_key_vault.kv.name
        keyvault_tenantid              = data.azurerm_client_config.current.tenant_id
    })}",
  ]
}
