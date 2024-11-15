locals {
  azapi_databases = jsondecode(data.azapi_resource_list.databases.output)
  databases       = length(var.what_to_migrate.databases) > 0 ? var.what_to_migrate.databases : [for database in local.azapi_databases.value : database.id]

  containers       = { for database in local.databases : database => [for container in jsondecode(data.azapi_resource_list.containers[database].output).value : container.name]}

  containers_per_database = { for pair in flatten([ for database, containers in local.containers : setproduct([database], containers) ]) : "${pair[0]}|${pair[1]}" => { database = pair[0], container = pair[1] } }
}