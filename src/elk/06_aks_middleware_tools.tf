resource "helm_release" "tls_cert_check" {
  name       = "tls-cert-check"
  chart      = "microservice-chart"
  repository = "https://pagopa.github.io/aks-microservice-chart-blueprint"
  version    = var.tls_cert_check_helm.chart_version
  namespace  = kubernetes_namespace.namespace.metadata[0].name

  values = [
    "${templatefile("${path.module}/helm/tls-cert.yaml.tpl",
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
module "letsencrypt_dev_elk" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//letsencrypt_credential?ref=v7.28.0"

  prefix            = var.prefix
  env               = var.env_short
  key_vault_name    = "${local.product}-${var.domain}-kv"
  subscription_name = var.subscription_name
}

resource "helm_release" "cert_mounter" {
  name         = "cert-mounter-blueprint"
  repository   = "https://pagopa.github.io/aks-helm-cert-mounter-blueprint"
  chart        = "cert-mounter-blueprint"
  version      = "1.0.4"
  namespace    = local.elk_namespace
  timeout      = 120
  force_update = true

  values = [
    "${
      templatefile("${path.root}/helm/cert-mounter.yaml.tpl", {
        NAMESPACE        = local.elk_namespace,
        DOMAIN           = var.domain
        CERTIFICATE_NAME = replace(local.kibana_hostname, ".", "-"),
        ENV_SHORT        = var.env_short,
      })
    }"
  ]
}
