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

variable "containers" {
  type = list(object({
    name                 = string
    storage_account_name = string
    container_name       = string
  }))

  description = "List of containers to migrate."
}