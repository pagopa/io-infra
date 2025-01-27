locals {
  private_endpoints = {
    "selc-evhns" = {
      "01" = {
        resource_id         = "/subscriptions/813119d7-0943-46ed-8ebe-cebe24f9106c/resourceGroups/selc-p-event-rg/providers/Microsoft.EventHub/namespaces/selc-p-eventhub-ns"
        subresource_names   = ["namespace"]
        private_dns_zone_id = var.dns_zones.servicebus.id
      }
    }
  }
}
