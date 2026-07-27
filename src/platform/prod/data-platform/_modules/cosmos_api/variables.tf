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

variable "secondary_location_pep_snet_id" {
  type        = string
  description = "Id of the subnet holding private endpoints in the secondary location"
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

variable "azure_adgroup_com_admins_object_id" {
  type        = string
  description = "Object Id of the Entra group for IO COM admins"
}


variable "azure_adgroup_com_devs_object_id" {
  type        = string
  description = "Object Id of the Entra group for IO COM devs"
}

variable "azure_adgroup_svc_admins_object_id" {
  type        = string
  description = "Object Id of the Entra group for IO SVC admins"
}

variable "azure_adgroup_svc_devs_object_id" {
  type        = string
  description = "Object Id of the Entra group for IO SVC devs"
}

variable "azure_adgroup_auth_admins_object_id" {
  type        = string
  description = "Object Id of the Entra group for IO AUTH admins"
}

variable "azure_adgroup_auth_devs_object_id" {
  type        = string
  description = "Object Id of the Entra group for IO AUTH devs"
}

variable "infra_identity_ids" {
  type        = list(string)
  description = "List of Identitiy Ids that should have access to Cosmos Account keys"
}
