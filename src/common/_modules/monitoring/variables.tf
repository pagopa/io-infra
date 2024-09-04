variable "project" {
  type        = string
  description = "IO prefix, short environment and short location"
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
  description = "Name of common resource group"
  default     = null
}

variable "kv_id" {
  type        = string
  description = "Id of the IO KeyVault"
}

variable "test_urls" {
  type = list(object({
    name                              = string
    host                              = string
    path                              = string
    frequency                         = number
    http_status                       = number
    ssl_cert_remaining_lifetime_check = number
    enabled                           = optional(bool, true)
    ssl_enabled                       = optional(bool, true)
  }))
}
