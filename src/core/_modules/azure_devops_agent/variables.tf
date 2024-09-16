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

variable "resource_group_name" {
  type        = string
  description = "Resource group name for VNet"
}

variable "cidr_subnet" {
  type        = list(string)
  description = "Azure DevOps agent network address space"
}

variable "image_name" {
  type        = string
  description = "Azure DevOps Agent image name"
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

variable "resource_groups" {
  type        = map(string)
  description = "Resource group names"
}

variable "datasources" {
  type        = map(any)
  description = "Common datasources"
}