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

variable "location_short" {
  type        = string
  description = "Azure region short name"
}

variable "subscription_id" {
  type        = string
  description = "Azure subscription id"
}

variable "tags" {
  type        = map(any)
  description = "Resource tags"
}

variable "resource_group_assets_cdn" {
  type        = string
  description = "Assets CDN resource group name"
}

variable "resource_group_external" {
  type        = string
  description = "External resource group name"
}

variable "resource_group_common" {
  type        = string
  description = "Common resource group name"
}

variable "dns_default_ttl_sec" {
  type        = number
  description = "Default TTL of DNS records"
}

variable "public_dns_zones" {
  type        = map(any)
  description = "Public dns zones information"
}

variable "external_domain" {
  type        = string
  description = "Domain for delegation"
}

variable "azure_adgroup_svc_devs_object_id" {
  type        = string
  description = "Object Id of the Entra group for enti & servizi"
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "Log analytics workspace id for metrics"
}