module "platform_service_bus_namespace_itn" {

  source = "./_modules/platform_service_bus"

  location = "italynorth"
  project  = local.project_itn
  prefix   = local.prefix

  resource_group_internal = local.resource_groups.itn.internal
  resource_group_event    = local.resource_groups.weu.event
  vnet_common             = local.core.networking.itn.vnet_common
  cidr_subnet             = "10.20.102.0/24"
  pep_snet_id             = local.core.networking.itn.pep_snet.id

  tags = local.tags
}