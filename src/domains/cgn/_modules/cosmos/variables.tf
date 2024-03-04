variable "project" {
  type = string
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "additional_location" {
  type        = string
  description = "Azure region"
}

variable "tags" {
  type = map(any)
}

variable "resource_group_name" {
  type = string
}

variable "private_endpoint_subnet_id" {
  type = string
}
