output "resource_group_cgn" {
  value = {
    id   = module.resource_groups.resource_group_cgn.id
    name = module.resource_groups.resource_group_cgn.name
  }
}

output "cosmos_cgn" {
  value = {
    id   = module.cosmos.cosmos_account_cgn.id
    name = module.cosmos.cosmos_account_cgn.name
  }
}
