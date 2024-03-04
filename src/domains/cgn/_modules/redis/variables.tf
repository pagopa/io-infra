variable "env_short" {
  type        = string
  description = "Environment name"
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
