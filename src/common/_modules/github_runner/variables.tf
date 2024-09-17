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
  description = "Resource group name"
}

variable "cidr_subnet" {
  type        = string
  description = "Azure DevOps agent network address space"
}

variable "vnet_common" {
  type = object({
    id                  = string
    name                = string
    resource_group_name = string
  })
  description = "Information of the common VNet"
}

variable "log_analytics_workspace_id" {
  type = string
}
