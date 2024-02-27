variable "env_short" {
  type        = string
  description = "Environment name"
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
