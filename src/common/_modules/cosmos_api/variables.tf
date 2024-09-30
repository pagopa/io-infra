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

variable "resource_group_internal" {
  type        = string
  description = "Internal resource group names"
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

variable "pep_snet" {
  type = object({
    id               = string
    name             = string
    address_prefixes = list(string)
  })
}

variable "secondary_location" {
  type        = string
  description = "The secondary location used for geo_replication of the cosmos database. If omitted, geo replication is not enabled."

  default = null
}

variable "documents_dns_zone" {
  type = object({
    id                  = string
    name                = string
    resource_group_name = string
  })
  description = "Private link documents dns zone information"
}

variable "allowed_subnets_ids" {
  type        = list(string)
  description = "List of the IDs of the subnets allowed to contact the cosmos account"
}

variable "error_action_group_id" {
  type        = string
  description = "Azure Monitor error action group id"
}
