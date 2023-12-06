locals {
  snapshot_secret_name            = "snapshot-secret"
  deafult_snapshot_container_name = "snapshotblob"
}

resource "azurerm_resource_group" "elk_rg" {
  name     = "${local.project}-rg"
  location = var.location

  tags = var.tags
}

module "elastic_stack" {
  depends_on = [
    azurerm_kubernetes_cluster_node_pool.elastic,
    kubernetes_secret.snapshot_secret
  ]

  source = "../../../terraform-azurerm-v3/elastic_stack"

  namespace      = local.elk_namespace
  nodeset_config = var.nodeset_config

  dedicated_log_instance_name = []

  eck_version = "2.9"
  eck_license = file("${path.module}/env/eck_license/pagopa-spa-4a1285e5-9c2c-4f9f-948a-9600095edc2f-orchestration.json")

  env_short = var.env_short
  env       = var.env

  kibana_external_domain = var.env_short == "p" ? "https://kibana.platform.pagopa.it/kibana" : "https://kibana.${var.env}.platform.pagopa.it/kibana"

  secret_name   = var.env_short == "p" ? "${var.location_short}${var.env}-kibana-internal-platform-pagopa-it" : "${var.location_short}${var.env}-kibana-internal-${var.env}-platform-pagopa-it"
  keyvault_name = module.key_vault.name

  kibana_internal_hostname = var.env_short == "p" ? "${var.location_short}${var.env}.kibana.internal.platform.pagopa.it" : "${var.location_short}${var.env}.kibana.internal.${var.env}.platform.pagopa.it"

  snapshot_secret_name = local.snapshot_secret_name
}

data "kubernetes_secret" "get_elastic_credential" {
  depends_on = [
    module.elastic_stack
  ]

  metadata {
    name      = "quickstart-es-elastic-user"
    namespace = local.elk_namespace
  }
}

# origInal
# locals {
#   kibana_url  = var.env_short == "p" ? "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@kibana.platform.pagopa.it/kibana" : "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@kibana.${var.env}.platform.pagopa.it/kibana"
#   elastic_url = var.env_short == "p" ? "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@kibana.platform.pagopa.it/elastic" : "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@kibana.${var.env}.platform.pagopa.it/elastic"
# }

# workaround
locals {
  kibana_url  = var.env_short == "d" ? "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@kibana.${var.env}.platform.pagopa.it/kibana" : "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@${local.kibana_hostname}/kibana"
  elastic_url = var.env_short == "d" ? "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@kibana.${var.env}.platform.pagopa.it/elastic" : "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@${local.kibana_hostname}/elastic"

}

