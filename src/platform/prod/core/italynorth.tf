module "custom_roles" {
  source  = "pagopa-dx/azure-core-infra/azurerm//modules/custom_roles"
  version = "~> 4.2"
}

module "private_endpoints_itn" {
  source = "./_modules/private_endpoint"

  project             = local.project_itn
  location            = "italynorth"
  resource_group_name = local.core.resource_groups.italynorth.common

  pep_snet_id = local.core.networking.itn.pep_snet.id
  dns_zones   = module.dns.zones.private_dns_zones

  tags = local.tags
}
