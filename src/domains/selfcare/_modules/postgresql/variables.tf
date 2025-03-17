variable "project" {
  type        = string
  description = "IO prefix and short environment"
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
  description = "Resource group name for the App Services"
}

variable "dev_portal_subnet_id" {
  type        = string
  description = "Subnet Id for devportal database"
}
