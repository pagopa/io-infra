variable "project" {
  type = string
}

variable "tags" {
  type = map(any)
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "subnet_redis_id" {
  type = string
}

variable "vnet_redis_id" {
  type = string
}
