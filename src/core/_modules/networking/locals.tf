locals {
  ddos_protection_plan = {
    id     = "/subscriptions/0da48c97-355f-4050-a520-f11a18b8be90/resourceGroups/sec-p-ddos/providers/Microsoft.Network/ddosProtectionPlans/sec-p-ddos-protection"
    enable = true
  }

  nonstandard = {
    weu = {
      ng       = "${var.project}-natgw"
      pep-snet = "pendpoints"
      vnet     = "${var.project}-vnet-common"
    }
  }
}
