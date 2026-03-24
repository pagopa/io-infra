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
  description = "Common resource group name"
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

variable "tags" {
  type        = map(any)
  description = "Resource tags"
}