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

variable "resource_groups" {
  type        = map(string)
  description = "Resource group names"
}

variable "index" {
    type = "number"
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

variable "override_app_settings" {
    type = map(string)
}

variable "allowed_subnets" {
    type = object({
      id = string 
    })
}

variable "azdoa_subnet" {
  type = object({
    id               = string
    name             = string
    address_prefixes = list(string)
  })
}

variable "application_insights" {
    type = object({
      id = string
      name = string
      resource_group_name = string
    })
}

variable "error_action_group_id" {
  type        = string
  description = "Azure Monitor error action group id"
}

variable "nat_gateway" {
  type = object({
    id = string
    name = string
    resource_group_name = string
  })
}

variable "key_vault_common" {
  type = object({
    id                  = string
    name                = string
    resource_group_name = string
  })
  description = "Information of the Key Vault Common"
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