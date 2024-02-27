variable "env_short" {
  type        = string
  description = "Environment name"
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

variable "subnet_id" {
  type = string
}

variable "private_dns_zone_sql_ids" {
  type = string
}
