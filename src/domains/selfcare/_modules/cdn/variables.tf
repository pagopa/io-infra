variable "location" {
  type = string
}

variable "tags" {
  type = map(any)
}

variable "project" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "dns_zone_name" {
  type = string
}
