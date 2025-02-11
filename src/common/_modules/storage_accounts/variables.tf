variable "resource_group_operations" {
  type        = string
  description = "Name of operations resource group"
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


variable "azure_adgroup_com_admins_object_id" {
  type        = string
  description = "Object Id of the Entra group for IO COM admins"
}


variable "azure_adgroup_com_devs_object_id" {
  type        = string
  description = "Object Id of the Entra group for IO COM devs"
}
