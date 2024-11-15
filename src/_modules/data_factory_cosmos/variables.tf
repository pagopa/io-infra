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

variable "data_factory_id" {
  description = "Data Factory id where to create resources."
  type        = string
}

variable "data_factory_principal_id" {
  description = "Data Factory principal id to grant access to."
  type        = string
}

variable "cosmos_accounts" {
  type = object({
    source = object({
      name                = string
      resource_group_name = string
    })

    target = object({
      name                = string
      resource_group_name = string
    })
  })
}

variable "what_to_migrate" {
  type = object({
    databases = optional(list(string), [])
  })

  description = "List of database names of the source cosmos db account to migrate. If no database names are provided, all of them are migrated."
}
