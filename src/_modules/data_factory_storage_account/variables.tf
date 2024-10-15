variable "environment" {
  type = object({
    prefix          = string
    env_short       = string
    location        = string
    domain          = optional(string)
    app_name        = string
    instance_number = string
  })

  description = "Values which are used to generate resource names and location short names. They are all mandatory except for domain, which should not be used only in the case of a resource used by multiple domains."
}

variable "data_factory" {
  description = "Data Factory information."
  type = map(object({
    id                  = string
    name                = string
    location            = string
    resource_group_name = string
  }))
}

variable "what_to_migrate" {
  type = object({
    blob = optional(object(
      {
        enabled = bool
        containers = optional(list(string), [])
      }), 
      { enabled = false }
    )
    table = optional(object(
      {
        enabled = bool
        tables = list(string)
      }), 
      { enabled = false }
    )
  })

  # validate that at least one between blob and table is enabled
  validation {
    condition     = anytrue([var.what_to_migrate.blob.enabled, var.what_to_migrate.table.enabled])
    error_message = "At least one between blob and table should be enabled."
  }

  # validate that if table is enabled, at least one table is specified
  validation {
    condition     = !(var.what_to_migrate.table.enabled && length(var.what_to_migrate.table.tables) == 0)
    error_message = "If table is enabled, at least one table should be specified."
  }

  description = "List of databases, file shares, containers and tables to migrate."
}
