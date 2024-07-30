## VPN

removed {
  from = module.vpn_snet

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.vpn

  lifecycle {
    destroy = false
  }
}

## DNS FORWARDER
removed {
  from = module.dns_forwarder_snet

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.dns_forwarder

  lifecycle {
    destroy = false
  }
}