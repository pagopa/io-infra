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
  type    = number
  default = 1
}

variable "name" {
  type        = string
  description = "Name of the backend (l1, l2, li, ...)"
  default     = null
}

variable "is_li" {
  type        = bool
  description = "Is this backend li type (async)?"
  default     = false
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

variable "plan_sku" {
  description = "App backend app plan sku size"
  type        = string
  default     = "P1v3"
}

variable "allowed_subnets" {
  type = list(string)
}

variable "slot_allowed_subnets" {
  type = list(string)
}

variable "allowed_ips" {
  type = list(string)
}

variable "slot_allowed_ips" {
  type = list(string)
}

variable "cidr_subnet" {
  type        = list(string)
  description = "App backend address space"
}

variable "application_insights" {
  type = object({
    id                  = string
    name                = string
    resource_group_name = string
    location            = string
    reserved_ips        = list(string)
  })
}

variable "ai_instrumentation_key" {
  type = string
}

variable "error_action_group_id" {
  type        = string
  description = "Azure Monitor error action group id"
}

variable "apim_snet_address_prefixes" {
  type = list(string)
}

variable "nat_gateways" {
  type = list(object({
    id                  = string
    name                = string
    resource_group_name = string
  }))
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

variable "redis_common" {
  type = object({
    hostname           = string
    ssl_port           = number
    primary_access_key = string
  })
  description = "Connection information to the common redis cluster"
  sensitive   = true
}

variable "autoscale" {
  type = object({
    default = optional(number)
    minimum = optional(number)
    maximum = optional(number)
  })
  default     = null
  description = "Autoscale capacity information"
}

variable "citizen_auth_assertion_storage_name" {
  type        = string
  description = "Use storage name from citizen_auth domain"
  default     = "lollipop-assertions-st"
}

variable "app_settings_override" {
  type        = map(string)
  default     = {}
  description = "Map of values that override the common app settings stored in app_settings.tf"
}

variable "backend_hostnames" {
  type = object({
    assets_cdn           = string
    services_app_backend = string
    lollipop             = string
    eucovidcert          = string
    cgn                  = string
    iosign               = string
    cgnonboarding        = string
    trial_system_api     = string
    trial_system_apim    = string
    iowallet             = string
  })
}