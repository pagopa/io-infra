variable "data_factories" {
  description = "Map of Data Factory"
  type        = map(object({
    name                = string
    location            = string
    resource_group_name = string
    tags                = map(string)
  }))
}

variable "azure_runtimes" {
  description = "Map of Azure Runtimes"
  type        = map(object({
    name        = string
    location    = string
    data_factory = string
  }))
}


variable "self_hosted_runtimes" {
  description = "Map of Self Hosted Runtimes"
  type        = map(object({
    name        = string
    data_factory = string
  }))
}

variable "linked_services" {
  description = "Map of linked services configurations"
  type = map(object({
    name            = string
    data_factory    = string
    storage_account = string
  }))
}

variable "linked_services_tables" {
  type = map(object({
    name              = string
    data_factory      = string
    storage_account   = string
    connection_string = string
  }))
}


variable "datasets" {
  description = "Map of dataset configurations"
  type = map(object({
    name           = string
    data_factory   = string
    type           = string
    linked_service = string
    parameters     = optional(map(string))
    fileName       = string
    folderPath     = string
  }))
}

variable "datasets_tables" {
  description = "Map of Azure Table datasets"
  type = map(object({
    name            = string
    data_factory    = string
    linked_service  = string
    table_name      = string
  }))
}




variable "storage_account_resource_groups" {
  description = "Map of storage account names to their resource group names"
  type        = map(string)
}

variable "pipelines" {
  description = "Map of pipeline configurations"
  type = map(object({
    name               = string
    data_factory       = string
    variables          = map(string)
    wildcard_file_name = string
    input_dataset      = string
    output_dataset     = string
  }))
}

variable "pipelines_tables" {
  description = "Map of Azure Data Factory pipelines"
  type = map(object({
    name                   = string
    data_factory           = string
    variables              = map(string)
    input_dataset          = string
    output_dataset         = string
  }))
}