# Variable to define Azure Data Factories to be created
# Requires:
# - name: unique identifier for the Data Factory
# - location: Azure region where the Data Factory will be deployed
# - resource_group_name: target resource group
# - tags: map of tags for resource organization
variable "data_factories" {
  description = "List of Data Factories to be created"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    tags                = map(string)
  }))
}

# Variable to define Data Factory pipelines
# Requires:
# - name: pipeline identifier
# - data_factory: reference to parent Data Factory
# - variables: map of pipeline variables
# - activities_json: JSON definition of pipeline activities
variable "pipelines" {
  description = "List of pipelines to be created in Data Factory"
  type = map(object({
    name                = string
    data_factory        = string
    variables           = map(string)  # Pipeline variables
    activities_json     = string       # Activities JSON content
  }))
}

# Variable to define Azure Integration Runtimes
# These are managed compute resources for data movement
# Requires:
# - name: runtime identifier
# - location: Azure region for runtime deployment
# - data_factory: reference to parent Data Factory
variable "azure_runtimes" {
  description = "List of Azure Integration Runtimes for Data Factory"
  type = map(object({
    name          = string
    location      = string
    data_factory  = string
  }))
}

# Variable to define Self-Hosted Integration Runtimes
# These are on-premises or private network runtimes
# Requires:
# - name: runtime identifier
# - data_factory: reference to parent Data Factory
variable "self_hosted_runtimes" {
  description = "List of Self-Hosted Integration Runtimes for Data Factory"
  type = map(object({
    name          = string
    data_factory  = string
  }))
}

# Variable to define Linked Services
# These establish connections to external data sources
# Requires:
# - name: service identifier
# - data_factory: reference to parent Data Factory
# - type: service type (e.g., AzureBlobStorage)
# - type_properties_json: connection properties in JSON format
# - storage_account: reference to associated storage account
variable "linked_services" {
  description = "List of linked services to be created for Data Factory"
  type = map(object({
    name                 = string
    data_factory        = string
    type                = string
    type_properties_json = string
    storage_account     = string
  }))
}

# Variable to map storage accounts to their resource groups
# Used to lookup existing storage accounts for linked services
variable "storage_account_resource_groups" {
  description = "Resource groups for each storage account used in linked services"
  type        = map(string)
}

# Variable to define Data Factory datasets
# These represent data structures within data stores
# Requires:
# - name: dataset identifier
# - data_factory: reference to parent Data Factory
# - type: dataset type
# - linked_service: reference to associated linked service
# Optional:
# - description, annotations, folder, parameters
# - additional_properties for extended configuration
# - schema_json for data structure definition
variable "datasets" {
  description = "List of datasets to be created for Data Factory"
  type = map(object({
    name                 = string
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