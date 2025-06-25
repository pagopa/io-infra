variable "project" {
  type        = string
  description = "IO prefix, short environment and short location"
}

variable "project_legacy" {
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

variable "resource_group_external" {
  type        = string
  description = "External resource group names"
}

variable "resource_group_common" {
  type        = string
  description = "Common resource group names"
}

variable "resource_group_security" {
  type        = string
  description = "Sec resource group names"
}

variable "datasources" {
  type        = map(any)
  description = "Common datasources"
}

variable "external_domain" {
  type        = string
  description = "Domain for delegation"
}

variable "public_dns_zones" {
  type        = map(any)
  description = "Public dns zones information"
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
  type        = list(string)
  description = "Application gateway address space."
}

variable "key_vault" {
  type = object({
    id                  = string
    name                = string
    resource_group_name = string
  })
  description = "Information of the Key Vault"
}

variable "key_vault_common" {
  type = object({
    id                  = string
    name                = string
    resource_group_name = string
  })
  description = "Information of the Key Vault Common"
}

#########################
## Application Gateway ##
#########################

variable "certificates" {
  type        = map(string)
  description = "Information of the certificates"
}

variable "backend_hostnames" {
  type        = map(list(string))
  description = "Information of the backend hostnames"
}

variable "min_capacity" {
  type    = number
  default = 0
}

variable "max_capacity" {
  type    = number
  default = 2
}

variable "alerts_enabled" {
  type        = bool
  description = "Enable alerts"
  default     = true
}

variable "deny_paths" {
  type        = list(string)
  description = "Regex patterns to deny requests"
}

variable "error_action_group_id" {
  type        = string
  description = "Azure Monitor error action group id"
}
