variable "resource_group_common" {
  type        = string
  description = "Name of common resource group"
}

variable "resource_group" {
  type        = string
  description = "Name of resource group that will contain all the APIM resources"
}

variable "project" {
  type        = string
  description = "IO prefix, short environment and short location"
}

variable "prefix" {
  type    = string
  default = "io"
  validation {
    condition = (
      length(var.prefix) < 6
    )
    error_message = "Max length is 6 chars."
  }
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "location_short" {
  type        = string
  description = "Azure region short name"
}

variable "tags" {
  type        = map(any)
  description = "Resource tags"
}

variable "vnet_common" {
  type = object({
    id                  = string
    name                = string
    address_space       = list(string)
    resource_group_name = string
  })
  description = "Information of the common VNet"
}

variable "cidr_subnet" {
  type        = string
  description = "APIM subnet CIDR block"
}

variable "ai_connection_string" {
  type = string
}

variable "key_vault" {
  type = object({
    id                  = string
    name                = string
    resource_group_name = string
  })
  description = "Information of the Key Vault"
}

variable "datasources" {
  type        = map(any)
  description = "Common datasources"
}

variable "azure_adgroup_admins_object_id" {
  type        = string
  description = "Object Id of the Entra ID group for subscription admins"
}

variable "azure_adgroup_developers_object_id" {
  type        = string
  description = "Object Id of the Entra ID group for developers"
}

variable "azure_adgroup_externals_object_id" {
  type        = string
  description = "Object Id of the Entra ID group for external collaborators"
}

variable "use_case" {
  type        = string
  description = "Use case for the APIM used for the SKU evaluation"
}