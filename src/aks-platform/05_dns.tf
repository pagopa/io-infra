import {
  to = kubernetes_manifest.coredns_custom
  id = "apiVersion=v1,kind=ConfigMap,namespace=kube-system,name=coredns-custom"
}

resource "kubernetes_manifest" "coredns_custom" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "ConfigMap"
    "metadata" = {
      "name"      = "coredns-custom"
      "namespace" = "kube-system"
      "labels" = {
        "addonmanager.kubernetes.io/mode" = "EnsureExists"
        "k8s-app"                         = "kube-dns"
        "kubernetes.io/cluster-service"   = "true"
      }
    }
    "data" = {
      "pagopa-d-evh-ns01.server"          = <<EOT
pagopa-d-evh-ns01.servicebus.windows.net:53 {
  forward pagopa-d-evh-ns01.servicebus.windows.net 8.8.8.8
}
EOT
      "pagopa-u-evh-ns01.server"          = <<EOT
pagopa-u-evh-ns01.servicebus.windows.net:53 {
  forward pagopa-u-evh-ns01.servicebus.windows.net 8.8.8.8
}
EOT
      "pagopa-p-evh-ns01.server"          = <<EOT
pagopa-p-evh-ns01.servicebus.windows.net:53 {
  forward pagopa-p-evh-ns01.servicebus.windows.net 8.8.8.8
}
EOT
      "pagopa-d-weu-core-evh-ns03.server" = <<EOT
pagopa-d-weu-core-evh-ns03.servicebus.windows.net:53 {
  forward pagopa-d-weu-core-evh-ns03.servicebus.windows.net 8.8.8.8
}
EOT
      "pagopa-u-weu-core-evh-ns03.server" = <<EOT
pagopa-u-weu-core-evh-ns03.servicebus.windows.net:53 {
  forward pagopa-u-weu-core-evh-ns03.servicebus.windows.net 8.8.8.8
}
EOT
      "pagopa-p-weu-core-evh-ns03.server" = <<EOT
pagopa-p-weu-core-evh-ns03.servicebus.windows.net:53 {
  forward pagopa-p-weu-core-evh-ns03.servicebus.windows.net 8.8.8.8
}
EOT
    }
  }

  depends_on = [module.aks]
}
