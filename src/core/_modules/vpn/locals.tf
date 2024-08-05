locals {
  nonstandard = {
    weu = {
      vpn                = "${var.project}-vpn"
      dns_forwarder_snet = "${var.project}-dnsforwarder"
      dns_forwarder      = "${var.project}-dns-forwarder"
    }
  }
}
