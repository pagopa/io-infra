locals {
  azapi_databases = jsondecode(data.azapi_resource_list.databases.output)
  databases       = length(var.what_to_migrate.databases) > 0 ? { for database in var.what_to_migrate.databases : "${data.azurerm_cosmosdb_account.source.id}/sqlDatabases/${database}" => database } : { for database in local.azapi_databases.value : database.id => reverse(split("/", database.id))[0] }

  containers = { for id, name in local.databases : name => [for container in jsondecode(data.azapi_resource_list.containers[id].output).value : { name = container.name, database_id = id, database_name = name }] }

  containers_per_database = {
    for pair in flatten([
      for database, containers in local.containers :
      [for container in containers : { database = database, container = container }]
    ]) :
    "${pair.database}|${pair.container.name}" => pair
  }
}
