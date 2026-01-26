variable "project" {
  type        = string
  description = "IO prefix and short environment"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "location_itn" {
  type        = string
  description = "Azure ItalyNorth region"
}

variable "tags" {
  type        = map(any)
  description = "Resource tags"
}

variable "resource_group_name_itn" {
  type        = string
  description = "Name of the resource group where resources will be created in ItalyNorth"
}

variable "project_itn" {
  type = string
}
