# Variabile opzionale per PostgreSQL
variable "subscription_id" {
  description = "nome della subscription"
  type        = string
  default     = "d7de83e0-0571-40ad-b63a-64c942385eae"
}

variable "data_factories" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    tags                = map(string)
  }))
}

variable "pipelines" {
  type = map(object({
    name                = string
    data_factory        = string
    variables           = map(string)  # Per le variabili della pipeline
    activities_json     = string       # Il contenuto JSON dell'attività
  }))
}


variable "azure_runtimes" {
  type = map(object({
    name        = string
    location    = string
    data_factory = string
  }))
}

variable "self_hosted_runtimes" {
  type = map(object({
    name        = string
    data_factory = string
  }))
}

variable "linked_services" {
  description = "Elenco dei linked services da creare per Data Factory"
  type = map(object({
    name                = string
    data_factory        = string
    type                = string
    type_properties_json = string
    storage_account     = string
  }))
}

variable "storage_account_resource_groups" {
  description = "Resource groups for each storage account used in linked services"
  type        = map(string)
}


variable "datasets" {
  type = map(object({
    name                = string
    data_factory        = string
    type                = string
    linked_service      = string
    type_properties_json = string
    description         = optional(string)
    annotations         = optional(list(string))
    folder              = optional(string)
    parameters          = optional(map(string))
    additional_properties = optional(map(string))
    schema_json         = optional(string)
  }))
}


