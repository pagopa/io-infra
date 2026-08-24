module "zones" {
  source = "./zones"

  vnets = var.dns.vnets

  resource_groups = var.dns.resource_groups

  tags = var.tags
}
