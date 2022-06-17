resource "kubernetes_manifest" "coredns_custom" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "ConfigMap"
    "metadata" = {
      "name"      = "coredns-custom"
      "namespace" = "kube-system"
    }
    "data" = {
      "pagopa-d-evh-ns01.server" = <<EOT
pagopa-d-evh-ns01.servicebus.windows.net:53 {
  forward pagopa-d-evh-ns01.servicebus.windows.net 8.8.8.8
}
EOT
      "pagopa-u-evh-ns01.server" = <<EOT
pagopa-u-evh-ns01.servicebus.windows.net:53 {
  forward pagopa-u-evh-ns01.servicebus.windows.net 8.8.8.8
}
EOT
      "pagopa-p-evh-ns01.server" = <<EOT
pagopa-p-evh-ns01.servicebus.windows.net:53 {
  forward pagopa-p-evh-ns01.servicebus.windows.net 8.8.8.8
}
EOT
    }
  }
}
