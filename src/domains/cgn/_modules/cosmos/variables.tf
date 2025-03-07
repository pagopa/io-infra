variable "project" {
  type        = string
  description = "IO prefix and short environment"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "secondary_locations" {
  type        = list(string)
  description = "Secondary Azure regions used for replication purposes"
}

variable "tags" {
  type        = map(any)
  description = "Resource tags"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group where resources will be created"
}

variable "private_endpoint_subnet_id" {
  type        = string
  description = "Id of the subnet which has private endpoints"
}

variable "private_endpoint_subnet_id_itn" {
  type        = string
  description = "Id of the subnet which has private endpoints"
}
