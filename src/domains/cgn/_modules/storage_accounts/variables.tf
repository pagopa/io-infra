variable "project" {
  type        = string
  description = "IO prefix and short environment"
}

variable "tags" {
  type        = map(any)
  description = "Resource tags"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group where resources will be created"
}

variable "subnet_pendpoints_id" {
  type        = string
  description = "Id of the subnet which holds private endpoints"
}
