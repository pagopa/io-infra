resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.domain
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "${local.project}-rg"
  location = var.location

  tags = var.tags
}

module "ingress" {
  source = "git::https://github.com/pagopa/azurerm.git//kubernetes_ingress?ref=v2.13.1"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tenant_id           = data.azurerm_subscription.current.tenant_id
  cluster_name        = local.aks_name

  name      = kubernetes_namespace.namespace.metadata[0].name
  namespace = kubernetes_namespace.namespace.metadata[0].name
  key_vault = data.azurerm_key_vault.kv

  host = "${var.instance}.${var.domain}.internal.io.pagopa.it"
  rules = [
    {
      path         = "/api/v1/email-validation/(.*)"
      service_name = "email-validation"
      service_port = 80
    }
  ]
}

module "pod_identity" {
  source = "git::https://github.com/pagopa/azurerm.git//kubernetes_pod_identity?ref=v2.13.1"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tenant_id           = data.azurerm_subscription.current.tenant_id
  cluster_name        = local.aks_name

  identity_name = "${local.project}-pod-identity"
  namespace     = kubernetes_namespace.namespace.metadata[0].name
  key_vault     = data.azurerm_key_vault.kv

  secret_permissions = ["get"]
}

resource "helm_release" "reloader" {
  name       = "reloader"
  repository = "https://stakater.github.io/stakater-charts"
  chart      = "reloader"
  version    = "1.0.16"
  namespace  = kubernetes_namespace.namespace.metadata[0].name

  set {
    name  = "reloader.watchGlobally"
    value = "false"
  }
}
