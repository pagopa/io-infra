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

variable "resource_group_common" {
  type        = string
  description = "Common resource group names"
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

variable "capacity_settings" {
  type = object({
    mode         = string # "fixed" or "autoscale"
    capacity     = optional(number, 0)
    min_capacity = optional(number, 0)
    max_capacity = optional(number, 2)
  })
  description = "Application Gateway capacity configuration. Use mode='fixed' with capacity, or mode='autoscale' with min_capacity and max_capacity"

  validation {
    condition     = contains(["fixed", "autoscale"], var.capacity_settings.mode)
    error_message = "Mode must be either 'fixed' or 'autoscale'."
  }

  validation {
    condition = (
      var.capacity_settings.mode == "fixed"
      ? var.capacity_settings.capacity >= 0 && var.capacity_settings.capacity <= 125
      : true
    )
    error_message = "When mode is 'fixed', capacity must be between 0 and 125."
  }

  validation {
    condition = (
      var.capacity_settings.mode == "autoscale"
      ? var.capacity_settings.min_capacity >= 0 && var.capacity_settings.min_capacity <= 100
      : true
    )
    error_message = "When mode is 'autoscale', min_capacity must be between 0 and 100."
  }

  validation {
    condition = (
      var.capacity_settings.mode == "autoscale"
      ? var.capacity_settings.max_capacity >= 2 && var.capacity_settings.max_capacity <= 125
      : true
    )
    error_message = "When mode is 'autoscale', max_capacity must be between 2 and 125."
  }

  validation {
    condition = (
      var.capacity_settings.mode == "autoscale"
      ? var.capacity_settings.min_capacity < var.capacity_settings.max_capacity
      : true
    )
    error_message = "When mode is 'autoscale', min_capacity must be less than max_capacity."
  }

  default = {
    mode         = "autoscale"
    capacity     = 0
    min_capacity = 0
    max_capacity = 2
  }
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

variable "subscription_id" {
  type        = string
  description = "Id of the current subscription"
}

variable "ioweb_kv" {
  type = object({
    name                = string
    resource_group_name = string
  })
  description = "IO-Web Key Vault used to store certificates"
}
