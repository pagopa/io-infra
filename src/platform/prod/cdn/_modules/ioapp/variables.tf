variable "prefix" {
  type    = string
  default = "io"
  validation {
    condition = (
      length(var.prefix) <= 6
    )
    error_message = "Max length is 6 chars."
  }
}

variable "env_short" {
  type    = string
  default = "p"
  validation {
    condition = (
      length(var.env_short) <= 1
    )
    error_message = "Max length is 1 chars."
  }
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "tags" {
  type        = map(any)
  description = "Resource tags"
}

variable "resource_group_cdn" {
  type        = string
  description = "CDN resource group name"
}

variable "storage_account_location" {
  type        = string
  description = "IOWEB storage account location"
}

variable "storage_account_resource_group" {
  type        = string
  description = "IOWEB storage account resource group"
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "Log analytics workspace ID for the CDN metrics"
}

variable "resource_group_external" {
  type        = string
  description = "External resource group name"
}

variable "public_dns_zones" {
  type        = map(any)
  description = "Public dns zones information"
}