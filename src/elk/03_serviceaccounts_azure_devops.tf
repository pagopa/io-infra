resource "kubernetes_namespace" "namespace_system" {
  metadata {
    name = "${var.domain}-system"
  }
}

resource "kubernetes_service_account" "azure_devops" {
  metadata {
    name      = "azure-devops"
    namespace = kubernetes_namespace.namespace_system.metadata[0].name
  }
  secret {
    name = "azure-devops"
  }
  automount_service_account_token = false
}

resource "kubernetes_secret" "azure_devops_secret" {
  metadata {
    name      = kubernetes_service_account.azure_devops.metadata[0].name
    namespace = kubernetes_namespace.namespace_system.metadata[0].name
    annotations = {
      "kubernetes.io/service-account.name" = kubernetes_service_account.azure_devops.metadata[0].name
    }
  }

  type = "kubernetes.io/service-account-token"
}

data "kubernetes_secret" "azure_devops_secret" {
  depends_on = [kubernetes_secret.azure_devops_secret]
  metadata {
    name      = kubernetes_service_account.azure_devops.metadata[0].name
    namespace = kubernetes_namespace.namespace_system.metadata[0].name
  }
  binary_data = {
    "ca.crt" = ""
    "token"  = ""
  }
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "azure_devops_sa_token" {
  depends_on   = [kubernetes_service_account.azure_devops]
  name         = "${local.aks_name}-azure-devops-sa-token"
  value        = data.kubernetes_secret.azure_devops_secret.binary_data["token"] # base64 value
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

# #tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "azure_devops_sa_cacrt" {
  depends_on   = [kubernetes_service_account.azure_devops]
  name         = "${local.aks_name}-azure-devops-sa-cacrt"
  value        = data.kubernetes_secret.azure_devops_secret.binary_data["ca.crt"] # base64 value
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

#-------------------------------------------------------------
#
# Role binding
#

resource "kubernetes_role_binding" "deployer_binding" {
  metadata {
    name      = "deployer-binding"
    namespace = kubernetes_namespace.namespace.metadata[0].name
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-deployer"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "azure-devops"
    namespace = kubernetes_namespace.namespace_system.metadata[0].name
  }
}

resource "kubernetes_role_binding" "system_deployer_binding" {
  metadata {
    name      = "system-deployer-binding"
    namespace = kubernetes_namespace.namespace_system.metadata[0].name
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "system-cluster-deployer"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "azure-devops"
    namespace = kubernetes_namespace.namespace_system.metadata[0].name
  }
}
