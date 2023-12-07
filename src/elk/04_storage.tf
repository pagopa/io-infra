resource "kubernetes_storage_class" "kubernetes_storage_class_hot" {
  metadata {
    name = "${local.project}-elastic-aks-storage-hot"
  }
  storage_provisioner = "disk.csi.azure.com"
  reclaim_policy      = "Delete"
  volume_binding_mode = "WaitForFirstConsumer"
  parameters = {
    skuName = var.elastic_hot_storage.storage_type
  }
  allow_volume_expansion = var.elastic_hot_storage.allow_volume_expansion

}