module "dns" {
  source = "./modules/dns"

  project = var.project

  dns_zones = var.dns.dns_zones

  vnets = var.dns.vnets

  resource_groups = var.dns.resource_groups

  # TODO: remove data when app gateway module is implemented
  app_gateway_public_ip = var.dns.app_gateway_public_ip

  apim_private_ip                             = var.dns.apim_private_ip
  platform_api_gateway_private_ip             = var.dns.platform_api_gateway_private_ip
  psn_application_gateway_private_endpoint_ip = var.dns.psn_application_gateway_private_endpoint_ip

  tags = var.tags
}
