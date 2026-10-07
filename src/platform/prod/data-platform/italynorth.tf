module "platform_service_bus_namespace_itn" {

  source = "./_modules/platform_service_bus"

  location = "italynorth"
  prefix   = local.prefix

  resource_group_internal = local.resource_groups.itn.internal
  resource_group_event    = local.resource_groups.weu.event
  pep_snet_id             = local.core.networking.itn.pep_snet.id

  tags = local.tags
}