locals {
  snapshot_secret_name            = "snapshot-secret"
  deafult_snapshot_container_name = "snapshotblob"
}

resource "azurerm_resource_group" "elk_rg" {
  name     = "${local.project}-rg"
  location = var.location

  tags = var.tags
}

resource "azurerm_storage_account" "elk_snapshot_sa" {
  name                     = replace(format("%s-sa", local.project), "-", "")
  resource_group_name      = azurerm_resource_group.elk_rg.name
  location                 = azurerm_resource_group.elk_rg.location
  account_tier             = "Standard"
  account_replication_type = "GZRS"
  min_tls_version          = "1.2"

  blob_properties {
    change_feed_enabled = var.elk_snapshot_sa.backup_enabled
    dynamic "container_delete_retention_policy" {
      for_each = var.elk_snapshot_sa.backup_enabled ? [1] : []
      content {
        days = var.elk_snapshot_sa.blob_delete_retention_days
      }

    }
    #    change_feed_retention_in_days = var.elk_snapshot_sa.backup_enabled ? var.elk_snapshot_sa.blob_delete_retention_days : null
    #    restore_policy {
    #      days = var.elk_snapshot_sa.blob_delete_retention_days
    #    }
    versioning_enabled = var.elk_snapshot_sa.backup_enabled
    dynamic "delete_retention_policy" {
      for_each = var.elk_snapshot_sa.backup_enabled ? [1] : []
      content {
        days = var.elk_snapshot_sa.blob_delete_retention_days
      }

    }
  }
}

resource "azurerm_storage_container" "snapshot_container" {
  name                  = local.deafult_snapshot_container_name
  storage_account_name  = azurerm_storage_account.elk_snapshot_sa.name
  container_access_type = "private"
}

resource "kubernetes_secret" "snapshot_secret" {
  metadata {
    name      = local.snapshot_secret_name
    namespace = kubernetes_namespace.namespace.metadata[0].name
  }
  data = {
    "azure.client.default.account" = replace(format("%s-sa", local.project), "-", "")
    "azure.client.default.key"     = azurerm_storage_account.elk_snapshot_sa.primary_access_key
  }

}

module "elastic_stack" {
  depends_on = [
    azurerm_kubernetes_cluster_node_pool.elastic,
  ]

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//elastic_stack?ref=v7.29.0"

  namespace      = kubernetes_namespace.namespace.metadata[0].name
  nodeset_config = var.nodeset_config

  dedicated_log_instance_name = []

  eck_version = "2.9"
  eck_license = file("${path.module}/env/eck_license/pagopa-spa-4a1285e5-9c2c-4f9f-948a-9600095edc2f-orchestration.json")

  env_short = var.env_short
  env       = var.env

  kibana_external_domain = "https://kibana.${var.prefix}.pagopa.it/kibana"

  secret_name   = "${var.location_short}${var.instance}-kibana-internal-${var.prefix}-pagopa-it"
  keyvault_name = module.key_vault.name

  kibana_internal_hostname = "${var.location_short}${var.instance}.kibana.internal.${var.prefix}.pagopa.it"

  snapshot_secret_name = local.snapshot_secret_name
}

data "kubernetes_secret" "get_elastic_credential" {
  depends_on = [
    module.elastic_stack
  ]

  metadata {
    name      = "quickstart-es-elastic-user"
    namespace = kubernetes_namespace.namespace.metadata[0].name
  }
}

# origInal
# locals {
#   kibana_url  = var.env_short == "p" ? "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@kibana.platform.pagopa.it/kibana" : "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@kibana.${var.env}.platform.pagopa.it/kibana"
#   elastic_url = var.env_short == "p" ? "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@kibana.platform.pagopa.it/elastic" : "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@kibana.${var.env}.platform.pagopa.it/elastic"
# }

# workaround
#TODO fix url values
locals {
  kibana_url  = var.env_short == "d" ? "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@kibana.${var.env}.platform.pagopa.it/kibana" : "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@${local.kibana_hostname}/kibana"
  elastic_url = var.env_short == "d" ? "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@kibana.${var.env}.platform.pagopa.it/elastic" : "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@${local.kibana_hostname}/elastic"

}

