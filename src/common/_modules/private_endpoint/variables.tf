variable "project" {
  type        = string
  description = "IO prefix, short environment and short location"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "tags" {
  type        = map(any)
  description = "Resource tags"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group namee"
}

variable "pep_snet_id" {
  type        = string
  description = "ID of the private endpoint subnet"
}

variable "dns_zones" {
  type        = map(any)
  description = "DNS zones"
}