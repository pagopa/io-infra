output "resource_group_cgn" {
  value = {
    id   = module.resource_groups.resource_group_cgn.id
    name = module.resource_groups.resource_group_cgn.name
  }
}

output "resource_group_cgn_be" {
  value = {
    id   = module.resource_groups.resource_group_cgn_be.id
    name = module.resource_groups.resource_group_cgn_be.name
  }
}
