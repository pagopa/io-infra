variable "project" {
  type        = string
  description = "IO prefix, short environment and short location"
}

variable "subscription_id" {
  type        = string
  description = "Id of the current subscription"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_common" {
  type        = string
  description = "Common resource group name for the networking resources"
}

variable "resource_group" {
  type        = string
  description = "Resource group name for the AGW resources"
}

variable "vnet_common" {
  type = object({
    id                  = string
    name                = string
    address_space       = list(string)
    resource_group_name = string
  })
  description = "Informations on the common VNet"
}

variable "cidr_subnet" {
  type        = list(string)
  description = "Application gateway address space"
}

variable "custom_domains_certificate_kv_name" {
  type        = string
  description = "Keyvault containing the TLS certificates for the custom domains"
}

variable "custom_domains_certificate_kv_rg" {
  type        = string
  description = "Resource group of the KV containing the custom domains certificates"
}

variable "autoscale_min_capacity" {
  type        = number
  description = "Minimum capacity for the autoscaler configuration"
  default     = 15
}

variable "autoscale_max_capacity" {
  type        = number
  description = "Maximum capacity for the autoscaler configuration"
  default     = 100
}

variable "resource_group_external" {
  type        = string
  description = "Public DNS zones external resource group"
}

variable "public_dns_zones" {
  type        = map(any)
  description = "Public DNS zones information"
}

variable "tags" {
  type        = map(any)
  description = "Resource tags"
}