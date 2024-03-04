variable "project" {
  type = string
}

variable "tags" {
  type = map(any)
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type = string
}

variable "subnet_pendpoints" {
  type = string
}
