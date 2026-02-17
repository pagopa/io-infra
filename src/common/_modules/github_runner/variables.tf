variable "prefix" {
  type        = string
  description = "Project prefix"
}

variable "env_short" {
  type        = string
  description = "Short environment"
}

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
  description = "Container App Environment network address space"
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
  type        = string
  description = "Id of the Log Analytics Workspace to use as log database"
}

variable "key_vault_pat_token" {
  type = object({
    name                = string
    resource_group_name = string
  })
}
