output "namespace" {
  value = {
    id                  = module.platform_service_bus_namespace.id
    name                = module.platform_service_bus_namespace.name
    resource_group_name = module.platform_service_bus_namespace.resource_group_name
  }
}
